class CreatePublisherUserJoinTable < ActiveRecord::Migration
  def self.up
    create_table :publishers_users, :id => false do |t|
      t.references :publisher
      t.references :user
    end

    add_index :publishers_users, :publisher_id
    add_index :publishers_users, :user_id
    add_index :publishers_users, [:publisher_id, :user_id]
  end

  def self.down
    drop_table :publishers_users
  end
end
