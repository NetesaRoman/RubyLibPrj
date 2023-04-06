class Author < ApplicationRecord
  has_many :books

  def update_name(new_name)
    self.class.connection.execute("UPDATE authors SET name='#{new_name}' WHERE id=#{id}")
    reload
  end

  def add_50_records
    50.times do |i|
      Author.create(
        name: Faker::Book.unique.author,
        )
    end
  end
end
