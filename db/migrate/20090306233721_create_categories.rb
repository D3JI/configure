class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.integer :shops_count, :default => 0
      t.integer :products_count, :default => 0
      t.string :belongs_to
      t.timestamps
    end
    add_index :categories, :name
    add_index :categories, :belongs_to
  end

  def self.down
    drop_table :categories
  end
end
