class UserSettingsController < ApplicationController
  include UserSettings::UserSettingsConcern

  def show
    presenter = UserSettingsPresenter.new UserSettings::Key.find(@current_user.id, params[:key])
    render json: presenter.as_json
  end

  def create
    presenter = UserSettingsPresenter.new UserSettings::Key.create_or_update(@current_user.id, params[:key], params[:value])
    render json: presenter.as_json
  end

  def create_once
    presenter = UserSettingsPresenter.new UserSettings::Key.create(@current_user.id, params[:key], params[:value])
    render json: presenter.as_json
  end

  def destroy
    presenter = UserSettingsPresenter.new UserSettings::Key.remove(@current_user.id, params[:key])
    render json: presenter.as_json
  end
end
