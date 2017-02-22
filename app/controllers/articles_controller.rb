class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :confirm_permission, only: [:edit, :update, :destroy]

  def index
    viewable_articles = Article.available_to(current_user)
    @articles = if params[:tag]
                  viewable_articles
                    .tagged_with(params[:tag])
                    .order(:updated_at)
                    .page(params[:page])
                    .per(1)
                else
                  viewable_articles
                    .order(:updated_at)
                    .page(params[:page])
                    .per(1)
                end
  end

  def show
    @comment = if params[:comment_id]
                 Comment.find(params[:comment_id])
               else
                 Comment.new
               end
    @comments = @article.comments.page(params[:page]).per(1)
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
    if @article.save
      if @article.group.private == false
        Slack.chat_postMessage(
          text: "#{current_user.username} created #{@article.title}!",
          username: 'Mr.Qiita Team',
          channel: SLACK_SHARE_CHANNEL
        )
      end
      redirect_to @article, notice: 'Your Article are successfuly posted'
    else
      redirect_to root_path
    end
  end

  def update
    if @article.update(article_params)
      if @article.group.private == false
        Slack.chat_postMessage(
          text: "@channel #{current_user.username}が記事「#{@article.title}」を更新しました！",
          username: 'Mr.Qiita Team',
          channel: SLACK_SHARE_CHANNEL
        )
        redirect_to @article, notice: 'Your Article are successfuly updated'
      end
    else
      redirect_to @article
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
      :group_id
    ).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def confirm_permission
    redirect_to '', alert: 'You do not have a permission' unless @article.user == current_user
  end
end
