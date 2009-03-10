class CreateEventsUsers < ActiveRecord::Migration
  def self.up
    create_table :events_users do |t|
      t.integer :user_id, :event_id
      t.string :phone
      t.integer :members_count
      t.timestamps
    end
    add_index :events_users, :user_id
    add_index :events_users, :event_id
    remove_column :events, :phone
    add_column :events, :phone, :string
  end

  def self.down
    drop_table :events_users
  end
end
