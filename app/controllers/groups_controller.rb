class GroupsController < ApplicationController

  before_action :redirect_to_index, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
    @belonged_groups = current_user.groups
    @not_belonged_groups = @groups - @belonged_groups
    @not_belonged_public_groups = @not_belonged_groups.select{|group| group.private == false}
  end

  def show
    @group = Group.find(params[:id])
    # グループがprivateの場合、メンバーじゃない人を弾く
    if @group.private == true && @group.users.include?(current_user) == false
      redirect_to groups_path
    end
    @users = @group.users
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)
    @group.users << current_user
    redirect_to @group
  end

  def edit
  end

  def update
    @group.update(group_params)
    redirect_to @group
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
    if current_user.groups.include?(@group) == false
      redirect_to groups_path
    end
  end
end
