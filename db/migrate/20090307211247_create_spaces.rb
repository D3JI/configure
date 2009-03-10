class CreateSpaces < ActiveRecord::Migration
  def self.up
    create_table :spaces do |t|
      t.integer :user_id
      t.string :address
      t.string :titlee
      t.text :description
      t.string :resolution
      t.string :composition
      t.timestamps
    end

  end

  def self.down
    drop_table :spaces
  end
end
