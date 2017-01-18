class AddUserNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :default => :email, :null => false
    add_index :users, :name, unique: true
  end
end
