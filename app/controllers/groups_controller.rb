class GroupsController < ApplicationController

  before_action :redirect_to_index, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
    @belonged_groups = current_user.groups
    @not_belonged_groups = @groups - @belonged_groups
  end

  def show
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
    params.require(:group).permit(:name, :body, :private)
  end

  def redirect_to_index
    @group = Group.find(params[:id])
    if current_user.groups.include?(@group) == false
      redirect_to groups_path
    end
  end
end
