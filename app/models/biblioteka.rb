class Biblioteka < ApplicationRecord
  has_many :books
  has_many :reader_cards

  def self.ransackable_attributes(auth_object = nil)
    %w[address created_at id name phone updated_at]
  end

  def update_name(new_name)
    self.class.connection.execute("UPDATE bibliotekas SET name='#{new_name}' WHERE id=#{id}")
    reload
  end



  def self.to_csv
    attributes = %w{name book_count genre_count user_names}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |biblioteka|
        @users = User.joins(:reader_card).where(reader_cards: {biblioteka_id: biblioteka.id})
        csv << [biblioteka.name, biblioteka.books.count, biblioteka.books.select(:genre_id).distinct.count, @users.each do |user| user.name end]
      end
    end
  end

  def add_50_records
    50.times do |i|
      Biblioteka.create(
        name: "Library #{i}",
        address: "Address #{i}"
      )
    end
  end

  def book_count
    books.count
  end

  def genre_count
    books.select(:genre_id).distinct.count
  end
end
