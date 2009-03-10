class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.string :title
      t.integer :user_id
      t.integer :topics_count, :default => 0
      t.integer :posts_count, :default => 0
      t.integer :last_post
      t.text :description
      t.timestamps
    end
    add_index :forums, :title
  end

  def self.down
    drop_table :forums
  end
end
