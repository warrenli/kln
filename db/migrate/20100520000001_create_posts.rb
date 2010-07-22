class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title,    :null => false
      t.text :body,       :null => false
      t.date :published_on
      t.integer :user_id, :null => false
      t.boolean :deleted, :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end

