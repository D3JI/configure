class AddPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :shop_id, :integer
    add_column :photos, :product_id, :integer
    add_index :photos, :shop_id
    add_index :photos, :product_id
  end

  def self.down
    remove_column :photos, :shop_id
    remove_column :photos, :product_id
    remove_index :photos, :shop_id
    remove_index :photos, :product_id
  end
end
