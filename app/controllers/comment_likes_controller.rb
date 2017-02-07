class CommentLikesController < ApplicationController
  def create
    @comment_like = CommentLike.new(comment_like_params)
    @commnent_likes = CommentLike.where(comment_id: comment_like_params[:comment_id])
    if @comment_like.save
      @article = Article.find(params[:article_id])
      @comments = @article.comments
      respond_to do |format|
        format.jsi
      end
    else
    end
  end

  def destroy
    comment_like = CommentLike.find_by(comment_like_params[:comment_id])
    @commnent_likes = CommentLike.where(comment_id: comment_like_params[:comment_id])
    if comment_like.destroy
      @article = Article.find(params[:article_id])
      @comments = @article.comments
      respond_to do |format|
        format.js
      end
    else
    end
  end

  private
  def comment_like_params
    params.permit(:comment_id).merge(user_id: current_user.id)
  end

end
