class User < ApplicationRecord
  has_one :reader_card

  def self.ransackable_attributes(auth_object = nil)
    %w[name age]
  end

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


end
