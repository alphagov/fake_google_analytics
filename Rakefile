GA_REQUESTS_FILE = "#{File.dirname(__FILE__)}/db/requests.yml"
namespace :fake_ga do
  desc "Start fake Google Analytics web server"
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
