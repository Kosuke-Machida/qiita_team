class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :user_id, null: false
      t.integer :article_id, null: false

      t.timestamps null: false
    end
  end
end
