class CommentsController < ApplicationController
  before_action :set_article, only: [:create, :edit, :update, :destroy]
  before_action :confirm_permission, only: [:edit, :update, :destroy]

  def create
    @comment = @article.comments.build(comment_params)
    return unless @comment.save
    set_comments
    Slack.chat_postMessage(
      text:
      "#{current_user.username} commented on your post!```#{@comment.body}```",
      username: 'Mr.Qiita Team',
      channel: @comment.user.slack_name
    )
    respond_to do |format|
      format.js
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment.update(comment_params)
    set_comments
    @comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment.destroy
    set_comments
    respond_to do |format|
      format.js
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comments
    @comments = @article.comments
  end

  def confirm_permission
    @comment = Comment.find(params[:id])
    return if current_user == @comment.user
    redirect_to @article, alert: 'You do not have a permission'
  end

  def comment_params
    params.require(:comment).permit(:body).merge(
      user_id: current_user.id,
      article_id: params[:article_id]
    )
  end
end
