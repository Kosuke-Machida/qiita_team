class AddDafultNameToUsers < ActiveRecord::Migration
  def up
      change_column :users, :name, :string,  null: false, default: 'guest'
    end

    def down
      change_column :users, :name, :text, null: false
    end
end
