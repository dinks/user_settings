require "user_settings/version"
require "user_settings/route_drawers/default"

require 'active_support/core_ext'

module UserSettings

  # Redis options are
  # * host
  # * port
  # * db
  # * redis_connection - Give a connection directly
  #
  mattr_accessor :redis_options
  @@redis_options = false
  @@redis_connection = nil

  mattr_accessor :base_path
  @@base_path = 'usettings/'

  mattr_accessor :route_drawer
  @@route_drawer = UserSettings::RouteDrawers::Default

  mattr_accessor :expiration_time
  @@expiration_time = 3.months

  def self.configure
    yield self
  end

  def self.redis
    if @@redis_options
      @@redis_connection ||= @@redis_options.delete(:redis_connection)
      if @@redis_connection == nil
        @@redis_connection ||= Redis.new({:host => 'localhost', :port => 6379, :db => 1}.merge(@@redis_options))
      end
    end
    @@redis_connection
  end

  require 'user_settings/engine' if defined?(Rails)

end
