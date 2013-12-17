class UserSettingsController < ApplicationController
  include UserSettings::UserSettingsConcern

  def show
    render json: create_presenter(:find).as_json
  end

  def create
    render json: create_presenter(:create).as_json
  end

  def create_once
    render json: create_presenter(:create, true).as_json
  end

  def destroy
    render json: create_presenter(:destroy).as_json
  end

  private
  def create_presenter(type, once=false)
    creation =  case type
                when :find
                  UserSettings::Key.find(@current_user.id, params[:key])
                when :destroy
                  UserSettings::Key.destroy(@current_user.id, params[:key])
                when :create
                  if once
                    UserSettings::Key.create(@current_user.id, params[:key], params[:value])
                  else
                    UserSettings::Key.create_or_update(@current_user.id, params[:key], params[:value])
                  end
                end

    UserSettingsPresenter.new creation
  end
end
