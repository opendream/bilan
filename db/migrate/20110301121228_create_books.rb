class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :isbn10, :limit => 10
      t.string :isbn13, :limit => 13
      t.string :cip
      t.string :edition
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
      t.integer :year
      t.integer :page
      t.float   :price
      t.integer :copies, :default => 0
      t.integer :publication_type
      t.string  :publication_type_other
      t.string :distributer_name
      t.string :distributer_address
      t.string :distributer_telephone
      t.string :distributer_fax
      t.string :distributer_email
      t.string :distributer_website
      t.integer :titles_per_year, :default => 0
      t.text    :synopsis
      t.boolean :translated, :default => false
      t.string  :translated_from
      t.string  :original_author

      t.references :publisher
      t.timestamps
    end

    add_index :books, :isbn10
    add_index :books, :isbn13
    add_index :books, :year
  end

  def self.down
    drop_table :books
  end
end
