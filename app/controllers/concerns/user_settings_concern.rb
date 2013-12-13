module UserSettings::UserSettingsConcern
  extend ActiveSupport::Concern

  included do

    layout false

    before_filter :check_if_authorized

    private
    def check_if_authorized
      unless @current_user
        head :unauthorized
        false
      end
    end

  end
end
