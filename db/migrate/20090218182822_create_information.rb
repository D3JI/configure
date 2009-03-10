class CreateInformation < ActiveRecord::Migration
  def self.up
    create_table :information do |t|
      t.string :name
      t.integer :user_id
      t.boolean :sex
      t.string :birthday
      t.string :blood
      t.integer :height
      t.integer :weight
      t.string :style
      t.string :from
      t.string :location
      
      t.string :job
      t.string :company
      t.string :rank
      t.string :school
      t.string :educational
      t.string :belief
      t.string :dress
      t.boolean :drink, :default => false
      t.boolean :smoke, :default => false
      t.string :personality
      t.string :hobiy

      t.string :qq
      t.string :msn
      t.string :telephone
      t.string :mobilephone
      t.string :mailadress
      t.string :zipcode
      t.timestamps
    end
    add_index :information, :user_id
  end

  def self.down
    drop_table :information
  end
end
