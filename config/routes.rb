Rails.application.routes.draw do
  if UserSettings.redis
    get     UserSettings.route_drawer.match_get_settings
    post    UserSettings.route_drawer.match_set_settings
    put     UserSettings.route_drawer.match_set_once_settings
    delete  UserSettings.route_drawer.match_remove_settings
  end
end
