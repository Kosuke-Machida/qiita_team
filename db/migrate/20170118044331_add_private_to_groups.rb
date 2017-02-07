class AddPrivateToGroups < ActiveRecord::Migration
  def up
    add_column :groups, :private, :boolean, default: false, null: false
  end

  def down
    remove_column :groups, :private
  end
end
