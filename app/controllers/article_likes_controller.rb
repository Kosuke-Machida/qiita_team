class ArticleLikesController < ApplicationController
  def create
    @article_like = ArticleLike.new(user_id: current_user.id, article_id: params[:article_id])
    @article_likes = ArticleLike.where(article_id: params[:article_id])
    if @article_like.save
      @article = Article.find(params[:article_id])
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    article_like = ArticleLike.find_by(user_id: current_user.id, article_id: params[:article_id])
    @article_likes = ArticleLike.where(article_id: params[:article_id])
    if article_like.destroy
      @article = Article.find(params[:article_id])
      respond_to do |format|
        format.js
      end
    end
  end
end
