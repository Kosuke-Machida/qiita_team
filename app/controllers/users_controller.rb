class UsersController < ApplicationController

  before_action :user_params

  def show
    @user =  User.find(user_params[:id])
    @stocks = Stock.where(user_id: @user.id)
    @stocks.each do |stock|
      @articles = Article.where(id: stock.article_id)
    end
  end

  private
  def user_params
    params
  end
end
