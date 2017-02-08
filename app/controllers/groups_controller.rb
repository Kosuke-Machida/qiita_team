class GroupsController < ApplicationController
  before_action :set_group_and_prevent_using_master_group, only: [:show, :edit, :update, :destroy]
  before_action :confirm_permission, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @group = Group.find(params[:id])
    # グループがprivateの場合、メンバーじゃない人を弾く
    if @group.private && @group.users.include?(current_user) == false
      redirect_to groups_path
    end
    @group_user = GroupUser.new
  end

  def new
    @group = Group.new
    @group_user = GroupUser.new
  end

  def create
    # userに紐づいたgroupの作成がcreateじゃないとできない(newだと中間テーブルのレコードができない)
    if @group = current_user.groups.create(group_params)
      redirect_to group_path(@group.id), notice: '新規グループを作成しました'
    else
      redirect_to groups_path, notice: '新規グループの作成ができませんでした'
    end
  end

  def edit; end

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

  def set_group_and_prevent_using_master_group
    @group = Group.find(params[:id])
    return unless @group.id == MASTER_GROUP_ID
    redirect_to groups_path, notice: 'お探しのグループは見つかりません'
  end

  def confirm_permission
    redirect_to groups_path unless current_user.groups.include?(@group)
  end
end
