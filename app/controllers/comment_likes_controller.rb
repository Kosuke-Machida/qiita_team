class CommentLikesController < ApplicationController
  def create
    @comment_like = CommentLike.create(comment_like_params)
    @commnent_likes = CommentLike.where(comment_id: comment_like_params[:comment_id])
    article = Article.find(params[:article_id])
    redirect_to article
  end

  def destroy
    @comment_like = CommentLike.find_by(comment_like_params)
    @comment_like.destroy
    @commnent_likes = CommentLike.where(comment_id: comment_like_params[:comment_id])
    article = Article.find(params[:article_id])
    redirect_to article
  end

  private
  def comment_like_params
    params.permit(:comment_id).merge(user_id: current_user.id)
  end

end
