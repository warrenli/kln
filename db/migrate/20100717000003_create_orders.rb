class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string  :customer,        :null => false
      t.string  :currency,        :null => false, :default => 'HKD'
      t.decimal :price,           :null => false, :default => 0.00, :precision => 8, :scale => 2
      t.boolean :delivered,       :null => false, :default => false
      t.date    :expiration_date, :null => false
      t.boolean :deleted,         :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end

