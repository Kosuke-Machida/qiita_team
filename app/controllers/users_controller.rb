class UsersController < ApplicationController
  before_action :user_params

  def show
    @user = User.find(user_params[:id])
    stocks = Stock.where(user_id: @user.id)
    stocked_articles_ids = stocks.map(&:article_id)
    @stocked_articles = Article.where(id: stocked_articles_ids)
  end

  private

  def user_params
    params
  end
end
