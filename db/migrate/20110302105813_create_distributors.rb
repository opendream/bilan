class CreateDistributors < ActiveRecord::Migration
  def self.up
    create_table :distributors do |t|
      t.string :name
      t.string :address
      t.string :telephone
      t.string :fax
      t.string :email
      t.string :website

      t.timestamps
    end

    add_index :distributors, :name
  end

  def self.down
    drop_table :distributors
  end
end
