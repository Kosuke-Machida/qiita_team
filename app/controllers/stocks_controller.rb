class StocksController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @stock = Stock.new(params.require(:stock).permit(:user_id, :article_id))
    if @stock.save
      redirect_to @article, notice: '記事をストックしました'
    else
      redirect_to  @article, alert: '記事のストックに失敗しました'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @stock = Stock.where(["user_id = ? and article_id = ? ", current_user.id, @article.id]).first
    if current_user.id == @stock.user_id
      @stock.destroy
      redirect_to @article, notice: '記事のストックを解除しました'
    else
      redirect_to @article, error: "You don't have permission"
    end
  end

end
