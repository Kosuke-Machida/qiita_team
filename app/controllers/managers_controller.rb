class ManagersController < ApplicationController

  # メンバーをusernameで検索するページ
  def search_member
    @group = Group.find(params[:group_id])
  end

  # patchでmanager_idだけをいじる
  def update
    @group = Group.find(params[:group_id])
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

end
