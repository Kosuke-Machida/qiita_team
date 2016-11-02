class CommentsController < ApplicationController

  def comment_params
    params.require(:comment).permit(:body, :user_id, :article_id)
  end

  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.save
    redirect_to @article
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.update(comment_params)
      redirect_to article_path(@article.id)
    else
      redirect_to @article, error: "You don't have permission"
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id
      @comment.destroy
      redirect_to @article
    else
      redirect_to @article, error: "You don't have permission"
    end
  end

end
