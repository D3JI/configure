class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :user_id
      t.integer :event_category_id
      t.string :title
      t.string :city
      t.integer :people
      t.integer :money
      t.integer :phone
      t.text :term
      t.text :introduction
      t.text :notes
      t.integer :status
      t.string :location
      t.datetime :started_at
      t.datetime :end_at
      t.timestamps
    end
    add_index :events, :event_category_id
    add_index :events, :title
  end

  def self.down
    drop_table :events
  end
end
