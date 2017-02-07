class ArticleLikesController < ApplicationController
  def create
    article_like = ArticleLike.new(article_like_param)
    return unless article_like.save
    set_article
    respond_to do |format|
      format.js
    end
  end

  def destroy
    article_like = ArticleLike.find_by(
      user_id: current_user.id,
      article_id: params[:article_id]
    )
    return unless article_like.destroy
    @article = Article.find(params[:article_id])
    respond_to do |format|
      format.js
    end
  end

  private

  def article_like_param
    params.permit(
      :article_id
    ).merge(
      user_id: current_user.id
    )
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
