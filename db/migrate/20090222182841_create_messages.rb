class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :parent_id
      t.string :title
      t.string :content
       t.datetime :sender_deleted_at
      t.datetime :recipient_deleted_at
      t.datetime :replied_at
      t.timestamps
    end
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
  end

  def self.down
    drop_table :messages
  end
end
