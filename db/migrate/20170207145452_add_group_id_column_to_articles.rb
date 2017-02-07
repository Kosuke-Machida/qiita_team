class AddGroupIdColumnToArticles < ActiveRecord::Migration
    def up
      add_column :articles, :group_id, :integer
    end

    def down
      remove_column :articles, :group_id
    end
end
