namespace :parse do
  desc "Parse and create libraries from Wikipedia"
  task wiki: :environment do
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

  task file: :environment do
    require 'csv'
    file_path = File.join(File.dirname(__FILE__),  'libraries.csv')
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

  task parallel: [:wiki, :file] do
    threads = []

    threads << Thread.new { Rake::Task['parse:wiki'].invoke }
    threads << Thread.new { Rake::Task['parse:file'].invoke }

    threads.each(&:join)
  end
end