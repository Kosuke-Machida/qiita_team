class CommentsController < ApplicationController
  before_action :set_article, only: [:create, :edit, :update, :destroy]
  before_action :confirm_permission, only: [:edit, :update, :destroy]

  def create
    @comment = @article.comments.new(comment_params)
    return unless @comment.save
    set_comments
    Slack.chat_postMessage(
      text: "#{@article.user.slack_name} #{current_user.username}があなたの投稿にコメントしました！",
      username: 'きーたちーむくん',
      channel: SLACK_SHARE_CHANNEL
    )
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @article, notice: 'コメントを編集しました'
    else
      redirect_to @article, notice: 'コメントの編集に失敗しました'
    end
  end

  def destroy
    @comment.destroy
    redirect_to @article
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
    redirect_to @article, notice: '権限がありません'
  end

  def comment_params
    params.require(:comment).permit(:body).merge(
      user_id: current_user.id,
      article_id: params[:article_id]
    )
  end
end
