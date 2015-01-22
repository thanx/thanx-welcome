Resque.redis = ENV['REDISCLOUD_URL'] || '127.0.0.1:6379'
Resque.inline = Rails.env.test?
