class UserSettingsController < ApplicationController
  include UserSettings::UserSettingsConcern

  def show
    presenter = UserSettingsPresenter.new UserSettings::Key.find(@current_user.id, params[:key])
    render json: presenter.as_json
  end

  def create
    presenter = create_presenter
    render json: presenter.as_json
  end

  def create_once
    presenter = create_presenter(true)
    render json: presenter.as_json
  end

  def destroy
    presenter = UserSettingsPresenter.new UserSettings::Key.remove(@current_user.id, params[:key])
    render json: presenter.as_json
  end

  private
  def create_presenter(once=false)
    creation =  if once
                  UserSettings::Key.create(@current_user.id, params[:key], params[:value])
                else
                  UserSettingsPresenter.new UserSettings::Key.create_or_update(@current_user.id, params[:key], params[:value])
    UserSettingsPresenter.new creation
    end
  end
end
