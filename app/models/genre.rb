class Genre < ApplicationRecord
  has_many :books

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def update_name(new_name)
    update(name: new_name)
  end

  def add_50_records
    50.times do |i|
      sql = "INSERT INTO genres (name) VALUES ('Genre #{i}')"
      ActiveRecord::Base.connection.execute(sql)
    end
  end

end

