Dir[File.join(Rails.root, 'app', 'jobs', '*.rb')].each { |file| require file }
config = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]
Resque.redis = Redis.new(:host => config['host'], :port => config['port'])
require 'resque/server'
Resque::Server.use Rack::Auth::Basic do |username, password|
  username == 'quemfoi'
  password == 'ipfquemfoi'
end

