class AddUserNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, :default => "guest", :null => false
    add_index :users, :username, unique: true
  end
end
