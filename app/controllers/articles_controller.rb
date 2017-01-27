class ArticlesController < ApplicationController

  before_action :move_to_articles, except: :index

  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
    @stock = Stock.new
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to @article
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end

  private

  def move_to_articles
    redirect_to action: :index unless user_signed_in?
  end

  def article_params
    params.require(:article).permit(:title, :body, :user_id, :tag_list)
  end

end
