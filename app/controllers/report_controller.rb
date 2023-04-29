class ReportController < ApplicationController

  require 'pdfkit'
  require 'csv'

  def generate_pdf
    @bibliotekas = Biblioteka.all
    @users = User.all
    @biblioteka = Biblioteka.first
    report_service = ReportService.new(@bibliotekas, @users, @biblioteka)
    kit = PDFKit.new(report_service.assemble_report)
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/report.css"
    send_data(kit.to_pdf, filename: "Libraries Report.pdf", type: 'application/pdf')
  end

  def generate_users_pdf
    @bibliotekas = Biblioteka.all
    @users = User.all
    @biblioteka = Biblioteka.first
    report_service = ReportService.new(@bibliotekas, @users, @biblioteka)
    kit = PDFKit.new(report_service.assemble_report_users)
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/report.css"
    send_data(kit.to_pdf, filename: "Users Report.pdf", type: 'application/pdf')
  end

  def generate_lib_pdf
    @biblioteka = Biblioteka.find(params[:id])
    @users = User.joins(:reader_card).where(reader_cards: { biblioteka_id: @biblioteka.id })
    @bibliotekas = Biblioteka.all
    report_service = ReportService.new(@bibliotekas, @users, @biblioteka)

    kit = PDFKit.new(report_service.assemble_report_users)
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/report.css"
    send_data(kit.to_pdf, filename: "Library Report.pdf", type: 'application/pdf')
  end

  def generate_csv
    @bibliotekas = Biblioteka.all

    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=libs.csv"

      end

    end
  end



end
