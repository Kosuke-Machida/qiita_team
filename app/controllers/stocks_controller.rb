class StocksController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @stock = Stock.new(params.require(:stock).permit(:user_id, :article_id))
    @stock.save
    redirect_to @article
  end

  def destroy
    @article = Article.find(params[:article_id])
    @stock = Stock.where(user_id: current_user.id, article_id: @article.id).first
    if current_user.id == @stock.user_id
      @stock.destroy
      redirect_to @article
    else
      redirect_to @article, error: "You don't have permission"
    end
  end
end
