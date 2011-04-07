class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at

      t.references :attachable, :polymorphic => true
      t.timestamps
    end
    add_index :assets, [:attachable_id, :attachable_type]
  end

  def self.down
    drop_table :assets
  end
end
