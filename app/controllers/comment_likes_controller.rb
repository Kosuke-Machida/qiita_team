class CommentLikesController < ApplicationController
  before_action :set_article

  def create
    comment_like = CommentLike.new(comment_like_params)
    return unless comment_like.save
    set_comment
    Slack.chat_postMessage(
      text: "#{@comment.user.slack_name} #{current_user.username}があなたの投稿にいいねしました！",
      username: 'きーたちーむくん',
      channel: SLACK_SHARE_CHANNEL
    )
    respond_to do |format|
      format.js
    end
  end

  def destroy
    comment_like = CommentLike.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    return unless comment_like.destroy
    set_comment
    respond_to do |format|
      format.js
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

  def set_user
    user = User.find(params[:user_id])
  end
end
