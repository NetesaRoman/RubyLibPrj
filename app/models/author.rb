class Author < ApplicationRecord
  has_many :books

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end
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
