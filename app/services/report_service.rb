# frozen_string_literal: true

class ReportService
  def initialize(bibliotekas, users, biblioteka)
    @bibliotekas = bibliotekas
    @users = users
    @biblioteka = biblioteka
  end

  def assemble_report
    report = "<table id = 'modelsTable'> <thead id = 'modelsThead'>"
    report += "<tr><th > <p>Library Name  </p></th>"
    report += "<th > <p>Number of Books  </p></th>"
    report += "<th > <p>Number of Genres  </p></th>"
    report += "<th> <p>Users</p></th>"
    @bibliotekas.each do |biblioteka|
      @users = User.joins(:reader_card).where(reader_cards: { biblioteka_id: biblioteka.id })
      report += "</tr></thead> <tbody><tr>"
      report += "<td>" + biblioteka.name + "</td>"
      report += "<td>" + biblioteka.books.count.to_s + "</td>"
      report += "<td>" + biblioteka.books.select(:genre_id).distinct.count.to_s + "</td>"
      report += "<td><ul>"
      @users.each do |user|
        report += "<li>" + user.name + "</li>"
      end
    end
    report += "</table>"

    return report
  end

  def assemble_report_users

    report = "<div style='  display: flex; width: 1000px;'>
    <div style='margin-right: 1200px; margin-bottom: 100px'>
      <h2>Name:</h2>
      <p>"+ @biblioteka.name + "</p>
      <h2>Address:</h2>
      <p>"+ @biblioteka.address.to_s + "</p>
      <h2>Phone:</h2>
      <p>"+ @biblioteka.phone.to_s + "</p>
    </div>


  </div>
"


    report += "<table id = 'modelsTable'> <thead id = 'modelsThead'>"
    report += "<tr><th > <p>User Name  </p></th>"
    report += "<th > <p>User Age  </p></th>"
    report += "<th > <p>Reader card  </p></th>"
    @users.each do |user|

      report += "</tr></thead> <tbody><tr>"
      report += "<td>" + user.name + "</td>"
      report += "<td>" + user.age.to_s + "</td>"
      report += "<td>" + user.reader_card.to_s + "</td>"

    end
    report += "</table>"

    return report
  end


  def assemble_report_lib
    report = "<table id = 'modelsTable'> <thead id = 'modelsThead'>"
    report += "<tr><th > <p>User Name  </p></th>"
    report += "<th > <p>User Age  </p></th>"
    report += "<th > <p>Reader card  </p></th>"
    @users.each do |user|

      report += "</tr></thead> <tbody><tr>"
      report += "<td>" + user.name + "</td>"
      report += "<td>" + user.age.to_s + "</td>"
      report += "<td>" + user.reader_card.to_s + "</td>"

    end
    report += "</table>"

    return report
  end
end
