class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id, :null => false
      t.string  :email,   :null => true
      t.string  :author,  :null => true
      t.text    :body,    :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end

