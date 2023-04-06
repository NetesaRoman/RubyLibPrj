class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre
  belongs_to :biblioteka

  def update_title(new_title)
    update(title: new_title)
  end

  def add_50_records
    50.times do |i|
      Book.create(
        title: Faker::Book.unique.title,
        author_id: rand(1..50),
        genre_id: rand(1..50),
        biblioteka_id: rand(1..50)
      )
    end
  end

  def self.create_books_with_authors_view(view_name)
    connection.execute("CREATE VIEW #{view_name} AS
                      SELECT books.title, authors.name AS author_name
                      FROM books
                      INNER JOIN authors ON books.author_id = authors.id;")
  end

  def self.create_books_in_libraries__view(view_name)
    connection.execute("CREATE VIEW #{view_name} AS
                            SELECT books.title, bibliotekas.name AS biblioteka_name
                            FROM books
                            INNER JOIN bibliotekas ON books.biblioteka_id = bibliotekas.id;")
  end
end
