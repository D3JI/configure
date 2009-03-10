class AddUserCount < ActiveRecord::Migration
  def self.up
    add_column :users, :photos_count, :integer, :default => 0
    add_column :users, :profile, :string
  end

  def self.down
    remove_column :users, :photos_count
    remove_column :users, :profile
  end
end
