class AddManagerIdToGroups < ActiveRecord::Migration
  def up
    add_column :groups, :manager_id, :integer, null: false
  end

  def down
    remove_column :groups, :manager_id
  end
end
