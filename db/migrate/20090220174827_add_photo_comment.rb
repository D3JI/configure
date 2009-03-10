class AddPhotoComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :photo_id, :integer
    add_column :photos, :comments_count, :integer
  end

  def self.down
    remove_column :comments, :photo_id
    remove_column :photos, :comments_count
  end
end
