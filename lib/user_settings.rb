require "user_settings/version"
require "user_settings/route_drawers/default"

require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext'

module UserSettings

  mattr_accessor :redis
  @@redis = false

  mattr_accessor :base_path
  @@base_path = 'usettings/'

  mattr_accessor :route_drawer
  @@route_drawer = UserSettings::RouteDrawers::Default

  mattr_accessor :expiration_time
  @@expiration_time = 3.months

  def self.configure
    yield self
  end

  require 'user_settings/engine' if defined?(Rails)

end
