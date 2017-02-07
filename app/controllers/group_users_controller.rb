class GroupUsersController < ApplicationController
  before_action :set_group, only: [:new, :create, :destroy]

  # ユーザー招待の検索フォーム
  def new
    @group_user = GroupUser.new
  end

  def create
    user = User.find(group_user_params[:user_id])
    @group_user = GroupUser.new(group_user_params)
    if @group_user.save
      message = if user == current_user
                  "グループ「#{@group.name}」に参加しました"
                else
                  "グループ「#{@group.name}」に#{user.username}を招待しました"
                end
      redirect_to group_path(@group.id), notice: message
    else
      message = if user == current_user
                  "グループ「#{@group.name}」への参加に失敗しました"
                else
                  "グループ「#{@group.name}」に#{user.username}を招待できませんでした"
                end
      redirect_to '/groups', notice: message
    end
  end

  def destroy
    group_user = GroupUser.find(params[:id])
    if group_user.user_id == current_user.id
      group_user.destroy
      redirect_to '/groups', notice: "グループ「#{@group.name}」から抜けました"
    else
      redirect_to '/groups', alart: '権限がありません'
    end
  end

  private

  def group_user_params
    params.permit(:group_id, :user_id)
  end

  def set_group
    @group = Group.find(group_user_params[:group_id])
  end
end
