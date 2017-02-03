class GroupUsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.new(group_user_params)
    if @group_user.save
      redirect_to @group, notice: "グループ「#{@group.name}」に参加しました"
    else
      redirect_to '/groups', alart: "グループ「#{@group.name}」への参加に失敗しました"
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.find(params[:id])
    if @group_user.user_id = current_user.id
      @group_user.destroy
      redirect_to '/groups', notice: "グループ「#{@group.name}」から抜けました"
    else
      redirect_to '/groups', alart: "権限がありません"
    end
  end

  private
  def group_user_params
    params.permit(:group_id).merge(:user_id => current_user.id)
  end

end
