class ArticlesController < ApplicationController

  before_action :confirm_permission, only: [:edit, :update, :destroy]

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
  end

  def create
    @article = Article.new(article_params)
    if  @article.save
      redirect_to @article, notice: '新しく投稿しました'
    else
      redirect_to '', alert: '新しい投稿ができませんでした'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: '投稿を編集しました'
    else
      redirect_to @article, alert: '投稿の編集ができませんでした'
    end
  end

  def destroy
    @article.destroy
    redirect_to ''
  end

  private

  def confirm_permission
    @article = Article.find(params[:id])
    redirect_to '', alert: '権限がありません' if @article.user != current_user
  end

  def article_params
    params.require(:article).permit(:title, :body, :user_id, :tag_list)
  end

end
