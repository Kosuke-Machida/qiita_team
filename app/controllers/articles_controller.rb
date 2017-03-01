class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :protect_private_article, only: [:show, :edit, :update, :destroy]
  before_action :confirm_permission, only: [:edit, :update, :destroy]

  def index
    viewable_articles = Article.available_to(current_user)
    @tag = params[:tag] if params[:tag]
    @articles = if params[:tag]
                  viewable_articles
                    .tagged_with(params[:tag])
                    .order("updated_at DESC")
                    .page(params[:page])
                    .per(10)
                else
                  viewable_articles
                    .order("updated_at DESC")
                    .page(params[:page])
                    .per(10)
                end
  end

  def show
    @comment = Comment.new
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
               Group.find(Group::MASTER_GROUP_ID)
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
      @group = if params[:group_id]
                 Group.find(params[:group_id])
               else
                 Group.find(Group::MASTER_GROUP_ID)
               end
      flash.now[:alert] = "Some errors occured"
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Your Article are successfuly updated'
    else
      flash.now[:alert] = "Some errors occured"
      render 'edit'
    end
  end

  def destroy
    @article.tag_list = {}
    @article.destroy
    redirect_to root_path
  end

  def search
    @keyword = params[:keyword]
    viewable_articles = Article.available_to(current_user)
    @articles = viewable_articles
                  .body_include(params[:keyword])
                  .order("updated_at DESC")
                  .page(params[:page])
                  .per(10)
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

  def protect_private_article
    if @article.group.private && @article.group.users.include?(current_user) == false
      redirect_to root_path, alert: "You don't have a permission to refer this group"
    end
  end

  def confirm_permission
    redirect_to '', alert: 'You do not have a permission' unless @article.user == current_user
  end
end
