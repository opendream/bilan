class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :slug
      t.string :title
      t.text :body
      t.boolean :published, :default => true
      t.references :user
      t.timestamps
    end
    add_index :pages, :slug
  end

  def self.down
    drop_table :pages
  end
end
