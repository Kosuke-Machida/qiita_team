class ArticlesController < ApplicationController

  before_action :move_to_articles, except: :index

  def index
    @search_form = ArticleSearchForm.new(params[:search])
    if params[:tag]
    @articles = Article.tagged_with(params[:tag])
    else
      @articles = @search_form.search
      @articles = Article.all if @articles == Article
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
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end

  class ArticleSearchForm
    include ActiveModel::Model
    attr_accessor  :title, :body
    def search
      rel = Article
      rel = rel.where( title: title ) if title.present?
      rel = rel.where( body: title ) if body.present?
      rel
    end
  end

  private

  def move_to_articles
    redirect_to action: :index unless user_signed_in?
  end

end
