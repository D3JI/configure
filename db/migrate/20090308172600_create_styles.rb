class CreateStyles < ActiveRecord::Migration
  def self.up
    create_table :styles do |t|
      t.integer :user_id
      t.string :stylename
      t.timestamps
    end
    add_index :styles, :stylename
    add_index :styles, :user_id
  end

  def self.down
    drop_table :styles
  end
end
