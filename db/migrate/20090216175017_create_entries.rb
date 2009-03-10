class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :blog_id
      t.string :title
      t.text :content
      t.timestamps
    end
    add_index :entries, :user_id
    add_index :entries, :category_id
    add_column :users, :entries_count, :integer, :default => 0
    add_column :users, :views_count, :integer, :default => 0
  end

  def self.down
    drop_table :entries
  end
end
