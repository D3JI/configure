class ModifyEntry < ActiveRecord::Migration
  def self.up
    rename_column :entries, :category_id, :entry_category_id
    remove_index :entries, :category_id
    add_index :entries, :entry_category_id
  end

  def self.down
    rename_column :entries, :entry_category_id, :category_id
    remove_index :entries, :entry_category_id
    add_index :entries, :category_id
  end
end
