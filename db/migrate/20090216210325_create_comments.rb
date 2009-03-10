class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :entry_id
      t.text :content
      t.timestamps
    end
    add_column :entries, :comments_count, :integer
    rename_column :entries, :category_id, :entry_category_id
    remove_index :entries, :category_id
    add_index :entries, :entry_category_id
  end

  def self.down
    rename_column :entries, :entry_category_id, :category_id
    remove_index :entries, :entry_category_id
    add_index :entries, :category_id
    drop_table :comments
  end
end
