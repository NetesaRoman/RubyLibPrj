class Genre < ApplicationRecord
  has_many :books

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

