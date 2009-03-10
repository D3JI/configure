class CreateShops < ActiveRecord::Migration
  def self.up
    create_table :shops do |t|
      t.integer :user_id, :category_id, :products_count, :category_parent
      t.string :shopname, :surename, :IDcard, :phone, :email, :address, :postcode
      t.integer :status
      t.boolean :is_recomend, :default => false
      t.text :description
      t.timestamps
    end
    add_index :shops, :shopname
    add_index :shops, :category_id
  end

  def self.down
    drop_table :shops
  end
end
