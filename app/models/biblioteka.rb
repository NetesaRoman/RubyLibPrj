class Biblioteka < ApplicationRecord
  has_many :books
  has_many :reader_cards

  def update_name(new_name)
    self.class.connection.execute("UPDATE bibliotekas SET name='#{new_name}' WHERE id=#{id}")
    reload
  end

  def add_50_records
    50.times do |i|
      Biblioteka.create(
        name: "Library #{i}",
        address: "Address #{i}"
      )
    end
  end
end
