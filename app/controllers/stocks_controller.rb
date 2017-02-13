class StocksController < ApplicationController
  before_action :set_article, only: [:create, :destroy]
  before_action :set_stock, only: [:destroy]

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      Slack.chat_postMessage(
        text: "#{@article.user.slack_name} #{current_user.username}があなたの投稿をストックしました！",
        username: 'きーたちーむくん',
        channel: SLACK_SHARE_CHANNEL
      )
      redirect_to article_path(@article), notice: 'You successfuly stocked the article'
    else
      redirect_to article_path(@article), alert: 'You failed to stock the article'
    end
  end

  def destroy
    if current_user.id == @stock.user_id
      @stock.destroy
      redirect_to article_path(@article), notice: 'You successfuly unstocked the article'
    else
      redirect_to article_path(@article), error: 'You failed to unstock the article'
    end
  end

  private

  def stock_params
    params.permit(:article_id).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_stock
    @stock = @article.stocks.find_by(user_id: current_user)
  end

  def confirm_permission
    return if current_user.stocks.include?(@stock)
    redirect_to article_path(@article)
  end
end
