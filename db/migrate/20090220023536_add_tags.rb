class AddTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
    end
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :taggable_id
      t.string :taggable_type
      t.datetime :created_at
    end
  end

  def self.down
  end
end
