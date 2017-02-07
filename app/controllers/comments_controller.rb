class CommentsController < ApplicationController

  before_action :set_article, only: [:new, :create, :edit, :update, :destroy]
  before_action :confirm_permission, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @article.comments.new(comment_params)
    @comment.save
    redirect_to @article
  end

  def edit
  end

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

  def confirm_permission
    @comment = Comment.find(params[:id])
    unless current_user.id  == @comment.user_id
      redirect_to @article, notice: '権限がありません'
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :article_id)
  end
end
