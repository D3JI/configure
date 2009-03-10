class CreateUsermodels < ActiveRecord::Migration
  def self.up
    create_table :usermodels do |t|
      t.integer :user_id
      t.boolean :profile_model, :default => 1
      t.boolean :board_model, :default => 1
      t.boolean :article_model, :default => 1
      t.boolean :friend_model, :default => 1
      t.boolean :entry_model, :default => 1
      t.boolean :album_model, :default => 1
      t.boolean :visit_model, :default => 1
      t.boolean :space_model, :default => 1
      t.timestamps
    end
    add_index :usermodels, :user_id
  end

  def self.down
    drop_table :usermodels
  end
end
