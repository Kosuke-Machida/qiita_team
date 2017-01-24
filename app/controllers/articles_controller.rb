class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(article_params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(article_params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(article_params)
    redirect_to @article
  end

  def destroy
    @article = Article.find(article_params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end

end
