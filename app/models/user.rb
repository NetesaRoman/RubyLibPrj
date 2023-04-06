class User < ApplicationRecord
  has_one :reader_card

  def update_email(new_email)
    update(email: new_email)
  end

  def add_50_records
    50.times do |i|
      name = Faker::Name.unique.name.gsub("'", "''")
      email = Faker::Internet.unique.email.gsub("'", "''")
      sql = "INSERT INTO users (name, email) VALUES ('#{name}', '#{email}')"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

  def self.create_users_books_view(view_name)
    connection.execute("CREATE VIEW #{view_name} AS
                            SELECT users.name AS user_name, books.title AS book_title
                            FROM users
                            INNER JOIN user_books ON users.id = user_books.user_id
                            INNER JOIN books ON user_books.book_id = books.id;")
  end

  def self.create_reader_cards_books_view(view_name)
    connection.execute("CREATE VIEW #{view_name} AS
                            SELECT reader_cards.card_number, books.title AS book_title
                            FROM reader_cards
                            INNER JOIN reader_cards_books ON reader_cards.id = reader_cards_books.reader_card_id
                            INNER JOIN books ON reader_cards_books.book_id = books.id;")
  end
end
