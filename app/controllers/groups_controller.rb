class GroupsController < ApplicationController

  before_action :redirect_to_index, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    # グループがprivateの場合、メンバーじゃない人を弾く
    if @group.private == true && @group.users.include?(current_user) == false
      redirect_to groups_path
    end
    @users = @group.users
    @manager = @users.find_by(id: @group.manager_id)
  end

  def new
    @group = Group.new
  end

  def create
    @user = current_user
    if @group = Group.create(group_params)
      redirect_to @group, notice: '新規グループを作成しました'
    else
      redirect_to '/groups', alart: '新規グループの作成ができませんでした'
    end
  end

  def edit
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to @group, notice: 'グループを更新しました'
    else
      redirect_to @group, alart: 'グループの更新ができませんでした'
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  # privateのグループにおけるinviteのaction
  def invite
    @group = Group.find(params[:id])
    @users = User.where('username LIKE(?)', "%#{params[:keyword]}%").limit(5)
    @group_user = GroupUser.new
  end

  # groupのmanagerが権限をメンバーに与えるaction
  def change_manager
    @group = Group.find(params[:id])
    @users = User.where('username LIKE(?)', "%#{params[:keyword]}%").limit(5)
  end

  private
  def group_params
    params.require(:group).permit(:name, :body, :private, :manager_id)
  end

  def redirect_to_index
    @group = Group.find(params[:id])
      redirect_to groups_path if current_user.groups.include?(@group) == false
  end

end
