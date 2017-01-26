class ArticlesController < ApplicationController

  def index
    if params[:tag]
    @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(article_params[:id])
    @comments = @article.comments
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(article_params[:id])
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :body, :user_id, :tag_list))
    @article.save
    redirect_to @article
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(params.require(:article).permit(:title, :body, :user_id, :tag_list))
    redirect_to @article
  end

  def destroy
    @article = Article.find(article_params[:id])
    @article.destroy
    redirect_to root_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end

end
