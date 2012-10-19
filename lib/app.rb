GA_REQUESTS_FILE = "#{File.dirname(__FILE__)}/../db/requests.yml"
GA_REQUESTS = File.exist?(GA_REQUESTS_FILE) ? YAML.load_file(GA_REQUESTS_FILE) : []

def ensure_yaml_file_exists(file)
  File.open(file, 'w') do |f|
    f.write "---\n"
  end unless File.exist?(file)
end

def append_request_to_yaml_file(request, file)
  File.open(file, 'a') do |f|
    f.write(YAML.dump([request]).gsub("---\n", ''))
  end
end

get '/__utm.gif' do
  request = params.merge('timestamp' => Time.now)
  GA_REQUESTS << request

  ensure_yaml_file_exists(GA_REQUESTS_FILE)
  append_request_to_yaml_file(request, GA_REQUESTS_FILE)

  cache_control "no-cache, no-cache=Set-Cookie, proxy-revalidate"
  send_file 'public/ga/__utm.gif'
end

delete '/' do
  GA_REQUESTS = []
  File.delete(GA_REQUESTS_FILE) if File.exist?(GA_REQUESTS_FILE)

  [204, ""]
end

get %r{.*/ga.js} do
  send_file 'public/ga/ga.js'
end

get %r{.*/ga_debug.js} do
  send_file 'public/ga/ga_debug.js'
end

get '/list' do
  content_type :json
  GA_REQUESTS.to_json
end

get '/events' do
  content_type :json
  GA_REQUESTS.select { |requests|
    requests['utmt'] == 'event'
  }.map { |request|
    request['utme'] =~ /5\((.*)\*(.*)\*(.*)\)8\(.*\)9\(.*\)/
    {:format => $1, :event => $3, :need_id => $2, :time => request['timestamp']}
  }.to_json
end

