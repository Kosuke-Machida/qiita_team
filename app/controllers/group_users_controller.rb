class GroupUsersController < ApplicationController
  before_action :set_group, only: [:create, :destroy]
  before_action :set_user, only: [:create]

  # ユーザー招待の検索フォーム
  def new
    @group_user = GroupUser.new
  end

  def create
    @group_user = GroupUser.new(group_user_params)
    if @group_user.save
      if user.id == current_user.id
        redirect_to group_path(@group.id), notice: "グループ「#{@group.name}」に参加しました"
      else
        redirect_to group_path(@group.id), notice: "グループ「#{@group.name}」に#{user.username}を招待しました"
      end
    else
      if user_id == current_user.id
        redirect_to '/groups', notice: "グループ「#{@group.name}」への参加に失敗しました"
      else
        redirect_to '/groups', notice: "グループ「#{@group.name}」に#{user.username}を招待できませんでした"
      end
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

  def set_user
    user = User.find(group_user_params[:user_id])
  end
end
