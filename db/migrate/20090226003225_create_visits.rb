class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :user_id
      t.integer :guest_id
      t.string :url
      t.timestamps
    end
    add_index :visits, :user_id
    add_index :visits, :guest_id
  end

  def self.down
    drop_table :visits
  end
end
