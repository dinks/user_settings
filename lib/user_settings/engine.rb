module UserSettings
  class Engine < Rails::Engine
    initializer 'Require concerns path' do |app|
      concerns_path = 'app/controllers/concerns'

      unless app.paths.keys.include?(concerns_path)
        app.paths.add(concerns_path)
      end

      require 'concerns/user_settings_concern'
    end
  end
end
