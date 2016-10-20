class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :title
      t.text :body
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
