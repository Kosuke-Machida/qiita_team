class ManagersController < ApplicationController
  before_action :set_group, only: [:change_manager, :update]

  # メンバーをusernameで検索するページ
  def change_manager; end

  # patchでmanager_idだけをいじる
  def update
    if @group.update(manager_params)
      redirect_to @group, notice: '管理者を変更しました'
    else
      redirect_to @group, notice: '管理者の変更ができませんでした'
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
