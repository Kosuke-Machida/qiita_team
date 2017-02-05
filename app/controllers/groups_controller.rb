class GroupsController < ApplicationController

  before_action :redirect_to_index, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    # グループがprivateの場合、メンバーじゃない人を弾く
    redirect_to groups_path if @group.private && @group.users.include?(current_user) == false
  end

  def new
    @group = Group.new
    @group_user = GroupUser.new
  end

  def create
    if @group = current_user.groups.create(group_params)
      redirect_to group_path(@group.id), notice: '新規グループを作成しました'
    else
      redirect_to groups_path, notice: '新規グループの作成ができませんでした'
    end
  end

  def edit
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to @group, notice: 'グループを更新しました'
    else
      redirect_to @group, notice: 'グループの更新ができませんでした'
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :body, :private, :manager_id)
  end

  def redirect_to_index
    @group = Group.find(params[:id])
      redirect_to groups_path unless current_user.groups.include?(@group)
  end

end
