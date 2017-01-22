class GroupUsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.new(params.require(:group_user).permit(:user_id, :group_id))
    @group_user.save
    redirect_to @group
  end

  def destroy
  end
end
