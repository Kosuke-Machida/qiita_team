class GroupUsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.new(params.require(:group_user).permit(:user_id, :group_id))
    if @group_user.save
      redirect_to @group, notice: "グループ「#{@group.name}」に参加しました"
    else
      redirect_to '/groups', alart: "グループ「#{@group.name}」への参加に失敗しました"
    end
  end

  def destroy
  end

  private

end
