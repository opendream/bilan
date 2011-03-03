class CreatePublications < ActiveRecord::Migration
  def self.up
    create_table :publications do |t|
      t.string :title
      t.string :author
      t.string :isbn10, :limit => 10
      t.string :isbn13, :limit => 13
      t.text :cip
      t.string :edition, :default => '1'
      t.integer :year
      t.integer :page
      t.float :price
      t.integer :copy
      t.integer :publication_type
      t.string  :publication_type_other
      t.integer :title_per_year
      t.text :synopsis
      t.boolean :translated, :default => false
      t.string  :translated_from
      t.string  :original_author
      t.string :publisher_name
      t.string :publisher_name_en
      t.string :publisher_address
      t.string :publisher_address_en
      t.string :publisher_telephone
      t.string :publisher_fax
      t.string :publisher_email
      t.string :publisher_website
      t.string :press_name
      t.string :press_address
      t.string :press_telephone
      t.string :press_fax
      t.string :press_email
      t.string :press_website
      t.string :distributor_name
      t.string :distributor_address
      t.string :distributor_telephone
      t.string :distributor_fax
      t.string :distributor_email
      t.string :distributor_website

      t.references :publisher
      t.timestamps
    end

    add_index :publications, :title
    add_index :publications, :author
    add_index :publications, :isbn10
    add_index :publications, :isbn13
    add_index :publications, :year
    add_index :publications, :publication_type
    add_index :publications, :publisher_name
    add_index :publications, :press_name
    add_index :publications, :distributor_name
  end

  def self.down
    drop_table :publications
  end
end
