class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :user_id
      t.integer :item_id
      t.string :item_type
      t.boolean :public
      t.timestamps
    end
    add_index :activities, :user_id
    add_index :activities, :item_type
    add_index :activities, :item_id
  end

  def self.down
    drop_table :activities
  end
end
