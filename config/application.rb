require_relative "boot"

require "rails/all"

require 'pdfkit'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LibPrj
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    require 'pdfkit'
    config.middleware.use PDFKit::Middleware


    PDFKit.configure do |config|
      config.wkhtmltopdf = 'C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe'
      config.default_options = {
        :page_size => 'Legal',
        :print_media_type => true
      }
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
