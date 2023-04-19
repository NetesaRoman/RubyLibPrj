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


  def parse_file
    require 'csv'
    file_path = File.join(File.dirname(__FILE__), '..', 'assets', 'libraries.csv')
    table = CSV.parse(File.read(file_path), headers: true)

    100.times do |i|
      Biblioteka.create(
        name: table[i][3],
        address: table[i][4],
        city: table[i][5],
        zip_code: table[i][6]
      )
    end

  end

  def parse_wiki
    require 'nokogiri'
    require 'open-uri'

    doc = Nokogiri::HTML(URI.open('https://en.wikipedia.org/wiki/List_of_libraries'))
    list_items = doc.css('li')


    100.times do |i|
      Biblioteka.create(
        name: list_items[i].at_css('a').text,
        address: list_items[i].text.gsub(list_items[i].at_css('a').text, '').gsub(',', '').strip,

      )
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
