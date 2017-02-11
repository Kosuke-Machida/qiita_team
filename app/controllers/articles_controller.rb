class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :confirm_permission, only: [:edit, :update, :destroy]
  before_action :set_previewed_article, only: [:create, :update]

  def index
    viewable_articles = Article.available_to(current_user)
    @articles = viewable_articles
  end

  def show
    @comments = @article.comments
    @stock = Stock.new
    @article_like = ArticleLike.find_by(
      user_id: current_user.id,
      article_id: params[:article_id]
    )
  end

  def new
    @group = if params[:group_id]
               Group.find(params[:group_id])
             else
               Group.find(MASTER_GROUP_ID)
             end
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    if params[:preview_button] || !@article.save
      render 'preview.js.erb'
    else
      redirect_to @article, notice: '新しい投稿しました'
    end
  end

  def update
    if params[:preview_button] || !@article.update(article_params)
      render 'preview.js.erb'
    else
      redirect_to @article, notice: '投稿を編集しました'
    end
  end

  def destroy
    @article.destroy
    redirect_to ''
  end

  def search
    viewable_articles = Article.available_to(current_user)
    @articles = viewable_articles.body_include(params[:keyword])
    @keyword = params[:keyword]
    respond_to do |format|
      format.js
    end
  end

  private

  def article_params
    params.require(:article).permit(
      :title,
      :body,
      :tag_list,
      :group_id,
      :preview_button
    ).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def set_previewed_article
    @previewed_article = Article.new(article_params)
  end

  def confirm_permission
    redirect_to '', alert: '権限がありません' unless @article.user == current_user
  end
end
