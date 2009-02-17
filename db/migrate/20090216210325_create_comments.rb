class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :entry_id
      t.text :content
      t.timestamps
    end
    add_column :entries, :comments_count, :integer
  end

  def self.down
    drop_table :comments
  end
end
