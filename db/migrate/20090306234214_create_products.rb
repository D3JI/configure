class CreateProducts < ActiveRecord::Migration
  #is_recommend 0--不推荐 1－－推荐
  def self.up
    create_table :products do |t|
      t.integer :shop_id, :category_id, :counts
      t.string :belongs_to
      t.string :name, :address
      t.text :introduction, :offer_description, :reservation_help
      t.boolean :is_recommend, :nill => false, :default => 0
      t.decimal :price
      t.float :discount
      t.timestamps
    end
    add_index :products, :name
    add_index :products, [:category_id,:shop_id]

  end

  def self.down
    drop_table :products
  end
end
