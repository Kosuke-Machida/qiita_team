class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users.all
  end

  def new
    @user = current_user
    @group = @user.groups.new
  end

  def create
    @user = current_user
    @group = @user.groups.new(group_params)
    @group.save
    redirect_to @group
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update_attributes(group_params)
    redirect_to @group
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :body)
  end
end
