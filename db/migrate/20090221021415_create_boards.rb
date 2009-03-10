class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.integer :user_id
      t.integer :boarder_id
      t.string :content
      t.string :reply
      t.timestamps
    end
    add_column :comments, :reply, :string
    add_column :users, :comments_count, :integer
  end

  def self.down
	remove_column :comments, :reply
    remove_column :users, :comments_count
    drop_table :boards
  end
end
