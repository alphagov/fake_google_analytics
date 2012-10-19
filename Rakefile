GA_REQUESTS_FILE = "#{File.dirname(__FILE__)}/db/requests.yml"
namespace :ga_proxy do
  desc "Start Google Analytics proxy web server"
  task :start do
    begin
      `rvmsudo ghost add www.google-analytics.com 127.0.0.1`
      `rvmsudo bundle exec rackup --port 80`
    ensure
      `rvmsudo ghost delete www.google-analytics.com`
    end
  end

  desc "Clear the saved Google Analytics requests"
  task :clear do
    File.delete(GA_REQUESTS_FILE) if File.exist?(GA_REQUESTS_FILE)
  end
end