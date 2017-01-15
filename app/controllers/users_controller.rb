class UsersController < ApplicationController
  def show
    @user =  User.find(params[:id])
    @stocks = Stock.where(user_id: @user.id)
    @stocks.each do |stock|
      @articles = Article.where(id: stock.article_id)
    end
  end
end
