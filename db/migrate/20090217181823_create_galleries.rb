class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.integer :user_id
      t.integer :photos_count, :default => 0, :null => false
      t.string :title
      t.string :description
      t.timestamps
    end
    add_index :galleries, :user_id
    add_column :users, :galleries_count, :integer
  end

  def self.down
    drop_table :galleries
  end
end
