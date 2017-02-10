class AddSlackNameColumnToUsers < ActiveRecord::Migration
  def up
    add_column :users, :slack_name, :string, null: false
  end

  def down
    remove_column :users, :slack_name
  end
end
