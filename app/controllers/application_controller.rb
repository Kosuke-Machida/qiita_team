class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :invite_user_to_master_group
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :slack_name, :image])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :slack_name, :image])
  end

  def invite_user_to_master_group
    return unless user_signed_in?
    # もしマスターチームに入ってなかったら入れる
    return if current_user.has_already_joined_in_master_team?
    group_user = GroupUser.new(user_id: current_user.id, group_id: MASTER_GROUP_ID)
    return if group_user.save
    redirect_to root_path
  end
end
