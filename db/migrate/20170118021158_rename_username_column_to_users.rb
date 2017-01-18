class RenameUsernameColumnToUsers < ActiveRecord::Migration
  def change
    def self.up
      rename_column :users, :username, :name
    end
    def self.down
      rename_column :users, :username, :name
    end
  end
end
