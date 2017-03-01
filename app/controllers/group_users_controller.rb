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
                  "You successfuly joined in #{@group.name}"
                else
                  Slack.chat_postMessage(
                    text:
                    "#{user.slack_name} #{current_user.username} invited you to the group #{@group.name}",
                    username: 'Mr.Qiita Team',
                    channel: user.slack_name
                  )
                  "You successfuly invited #{user.username} to #{@group.name}"
                end
      redirect_to group_path(@group.id), notice: message
    else
      message = if user == current_user
                  "You failed to join in #{@group.name}"
                else
                  "You failed to invite #{user.username} to「#{@group.name}}"
                end
      redirect_to '/groups', notice: message
    end
  end

  def destroy
    group_user = GroupUser.find(params[:id])
    if group_user.user_id == current_user.id
      group_user.destroy
      redirect_to '/groups', notice: "You successfuly left from #{@group.name}"
    else
      redirect_to '/groups'
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
