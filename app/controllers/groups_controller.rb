class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
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
    @group = Group.find(params[:id])
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
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :body)
  end
end
