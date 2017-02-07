class AddLikesCounttoArticles < ActiveRecord::Migration
  def up
    add_column :articles, :likes_count, :integer
  end

  def down
    remove_column :articles, :likes_count
  end
end
