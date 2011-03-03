class CreatePresses < ActiveRecord::Migration
  def self.up
    create_table :presses do |t|
      t.string :name
      t.string :address
      t.string :telephone
      t.string :fax
      t.string :email
      t.string :website

      t.timestamps
    end

    add_index :presses, :name
  end

  def self.down
    drop_table :presses
  end
end
