class ManagersController < ApplicationController
  before_action :set_group, only: [:change_manager, :update]

  # メンバーをusernameで検索するページ
  def change_manager; end

  # patchでmanager_idだけをいじる
  def update
    if @group.update(manager_params)
      redirect_to @group, notice: 'You successfuly gave your manager permission'
    else
      redirect_to @group, notice: 'You failed to give your manager permission'
    end
  end

  private

  def manager_params
    params.permit(:manager_id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
