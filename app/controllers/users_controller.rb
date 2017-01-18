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

  def join_group
    @group_user = GroupUser.new(params.permit(:user_id, :group_id))
    @group_user.save
    redirect_to Group.find(params[:group_id])
  end

end
