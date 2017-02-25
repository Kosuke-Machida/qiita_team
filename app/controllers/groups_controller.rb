class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :prevent_using_master_group, only: [:show, :edit, :update, :destroy]
  before_action :confirm_permission, only: [:edit, :update, :destroy]

  def index; end

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
    @group = Group.new(group_params)
    if @group.save
      @group.users << current_user
      redirect_to @group, notice: 'New Group was Successfuly created'
    else
      flash.now[:alert] = "Some errors occured"
      render 'new'
    end
  end

  def edit; end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to @group, notice: "Group #{@group.name} was Successfuly created"
    else
      flash.now[:alert] = "Some errors occured"
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :body, :private).merge(manager_id: current_user.id)
  end

  # Groupクラスのインスタンス変数を定義
  def set_group
    @group = Group.find(params[:id])
  end

  # masterグループにURLから処理を行おうとするのを防ぐ
  def prevent_using_master_group
    return unless @group.id == MASTER_GROUP_ID
    redirect_to groups_path, notice: 'Not Found'
  end

  # 紐づいていないuserが編集や削除をするのを防ぐ
  def confirm_permission
    redirect_to groups_path unless current_user.groups.include?(@group)
  end
end
