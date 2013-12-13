require 'user_settings'
require 'mock_redis'

UserSettings.configure do |c|
  redis = MockRedis.new

  c.redis = redis
end
