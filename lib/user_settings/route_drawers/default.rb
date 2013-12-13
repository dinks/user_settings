# Similar to https://github.com/thoughtbot/high_voltage/blob/master/lib/high_voltage.rb
module UserSettings
  module RouteDrawers
    class Default
      def self.match_get_settings
        {
          "/#{UserSettings.base_path}:key" => 'user_settings#show',
          :as => :get_user_settings,
          :format => :json
        }
      end

      def self.match_set_once_settings
        {
          "/#{UserSettings.base_path}:key" => 'user_settings#create_once',
          :as => :set_once_user_settings,
          :format => :json
        }
      end

      def self.match_set_settings
        {
          "/#{UserSettings.base_path}:key" => 'user_settings#create',
          :as => :set_user_settings,
          :format => :json
        }
      end

      def self.match_remove_settings
        {
          "/#{UserSettings.base_path}:key" => 'user_settings#destroy',
          :as => :remove_user_settings,
          :format => :json
        }
      end
    end
  end
end
