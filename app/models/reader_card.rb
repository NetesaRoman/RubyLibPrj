class ReaderCard < ApplicationRecord
  belongs_to :user
  belongs_to :biblioteka

  def update_issued_date(new_issued_date)
    self.class.connection.execute("UPDATE reader_cards SET issued_date='#{new_issued_date}' WHERE id=#{id}")
    reload
  end

  def add_50_records
    50.times do |i|
      sql = "INSERT INTO reader_cards (biblioteka_id, user_id, date_issued, date_expired) VALUES (#{Biblioteka.all.sample.id}, #{User.all.sample.id}, '#{Faker::Date.between(from: '2020-01-01', to: '2022-12-31')}', '#{Faker::Date.between(from: '2023-01-01', to: '2024-12-31')}' )"
      ActiveRecord::Base.connection.execute(sql)
    end
  end
end
