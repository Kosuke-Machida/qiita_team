class ArticleLikesController < ApplicationController
  def create
    @article_like = ArticleLike.create(user_id: current_user.id, article_id: params[:article_id])
    @article_likes = ArticleLike.where(article_id: params[:article_id])
    @article = Article.find(params[:article_id])
    redirect_to @article
  end

  def destroy
    article_like = ArticleLike.find_by(user_id: current_user.id, article_id: params[:article_id])
    article_like.destroy
    @article_likes = ArticleLike.where(article_id: params[:article_id])
    @article = Article.find(params[:article_id])
    redirect_to @article
  end
end
