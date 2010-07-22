class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string   :description, :null => false
      t.string   :priority,    :null => false
      t.datetime :due_on,      :null => false
      t.boolean :deleted,      :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end

