class CommentsController < ApplicationController
  before_action :set_article, only: [:new, :create, :edit, :update, :destroy]
  before_action :confirm_permission, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      Slack.chat_postMessage(
        text: "#{@article.user.slack_name} #{current_user.username} commented on your post!\n
                ```\n@comment.body\n```",
        username: 'Mr.Qiita Team',
        channel: SLACK_SHARE_CHANNEL
      )
      redirect_to @article
    else
      redirect_to @article
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @article
    else
      redirect_to @article
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

  def confirm_permission
    @comment = Comment.find(params[:id])
    return if current_user == @comment.user
    redirect_to @article, notice: '権限がありません'
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :article_id)
  end
end
