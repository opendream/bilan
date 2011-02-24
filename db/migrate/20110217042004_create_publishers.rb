class CreatePublishers < ActiveRecord::Migration
  def self.up
    create_table :publishers do |t|
      t.integer :owner_id
      t.string :name
      t.text :address
      t.string :telephone
      t.string :fax
      t.string :website
      t.string :facebook
      t.string :twitter
      t.timestamps
    end

    add_index :publishers, :owner_id
  end

  def self.down
    drop_table :publishers
  end
end
