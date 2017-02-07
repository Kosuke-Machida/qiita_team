class CommentLikesController < ApplicationController

  before_action :set_article
  before_action :set_comment_id_num

  def create
    comment_like = CommentLike.new(comment_like_params)
    if comment_like.save
      set_comment
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    comment_like = CommentLike.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    if comment_like.destroy
      set_comment
      respond_to do |format|
        format.js
      end
    end
  end

  private
  def comment_like_params
    params.permit(:comment_id).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def set_comment_id_num
    @comment_id_num = params[:comment_id]
  end
end
