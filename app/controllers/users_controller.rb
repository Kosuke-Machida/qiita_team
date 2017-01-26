class UsersController < ApplicationController

  before_action :user_params

  def show
    @user =  User.find(user_params[:id])
  end

  private
  def user_params
    params
  end
end
