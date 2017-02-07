class StocksController < ApplicationController

  before_action :set_article, only: [:create, :destroy]
  before_action :set_stock, only: [:destroy]

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      redirect_to article_path(@article), notice: '記事をストックしました'
    else
      redirect_to article_path(@article), alert: '記事のストックに失敗しました'
    end
  end

  def destroy
    if current_user.id == @stock.user_id
      @stock.destroy
      redirect_to article_path(@article), notice: '記事のストックを解除しました'
    else
      redirect_to article_path(@article), error: '権限がありません'
    end
  end

  private
  def stock_params
    params.require(:stock).permit(:user_id, :article_id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_stock
    @stock = Stock.where(["user_id = ? and article_id = ? ", current_user.id, @article.id]).first
  end

  def confirm_permission
    redirect_to article_path(@article) unless current_user.stocks.include?(@stock)
  end
end
