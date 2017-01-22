class UsersController < ApplicationController

  def show
    @user =  User.find(params[:id])
    @stocks = Stock.where(user_id: @user.id)
    @stocks.each do |stock|
      @articles = Article.where(id: stock.article_id)
    end
  end

  def search
    @group = Group.find(params[:group_id])
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%").limit(5)
    @group_user = GroupUser.new
  end

  def invite_group
    @group_user = GroupUser.create(params.permit(:user_id, :group_id))
    redirect_to Group.find(params[:group_id])
  end

  def search_member
    @group = Group.find(params[:group_id])
    @members = User.where('name LIKE(?)', "%#{params[:keyword]}%").limit(5)
  end

end
