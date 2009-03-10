class CreateTopicCategories < ActiveRecord::Migration
  def self.up
    create_table :topic_categories do |t|
      t.integer :forum_id
      t.string :name
      t.timestamps
    end
    add_index :topic_categories, :name
  end

  def self.down
    drop_table :topic_categories
  end
end
