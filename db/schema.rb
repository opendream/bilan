# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110418050122) do

  create_table "assets", :force => true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["attachable_id", "attachable_type"], :name => "index_assets_on_attachable_id_and_attachable_type"

  create_table "distributors", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "distributors", ["name"], :name => "index_distributors_on_name"

  create_table "pages", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "body"
    t.boolean  "published",  :default => true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], :name => "index_pages_on_slug"

  create_table "presses", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "presses", ["name"], :name => "index_presses_on_name"

  create_table "publications", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "isbn10",                 :limit => 10
    t.string   "isbn13",                 :limit => 13
    t.text     "cip"
    t.string   "edition",                              :default => "1"
    t.string   "year"
    t.string   "page"
    t.float    "price"
    t.string   "copy"
    t.integer  "publication_type"
    t.string   "publication_type_other"
    t.string   "title_per_year"
    t.text     "synopsis"
    t.boolean  "translated",                           :default => false
    t.string   "translated_from"
    t.string   "original_author"
    t.string   "publisher_name"
    t.string   "publisher_name_en"
    t.string   "publisher_address"
    t.string   "publisher_address_en"
    t.string   "publisher_telephone"
    t.string   "publisher_fax"
    t.string   "publisher_email"
    t.string   "publisher_website"
    t.string   "press_name"
    t.string   "press_address"
    t.string   "press_telephone"
    t.string   "press_fax"
    t.string   "press_email"
    t.string   "press_website"
    t.string   "distributor_name"
    t.string   "distributor_address"
    t.string   "distributor_telephone"
    t.string   "distributor_fax"
    t.string   "distributor_email"
    t.string   "distributor_website"
    t.integer  "publisher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publications", ["author"], :name => "index_publications_on_author"
  add_index "publications", ["distributor_name"], :name => "index_publications_on_distributor_name"
  add_index "publications", ["isbn10"], :name => "index_publications_on_isbn10"
  add_index "publications", ["isbn13"], :name => "index_publications_on_isbn13"
  add_index "publications", ["press_name"], :name => "index_publications_on_press_name"
  add_index "publications", ["publication_type"], :name => "index_publications_on_publication_type"
  add_index "publications", ["publisher_name"], :name => "index_publications_on_publisher_name"
  add_index "publications", ["title"], :name => "index_publications_on_title"
  add_index "publications", ["year"], :name => "index_publications_on_year"

  create_table "publishers", :force => true do |t|
    t.integer  "owner_id"
    t.string   "name"
    t.string   "name_en"
    t.string   "address"
    t.string   "address_en"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publishers", ["owner_id"], :name => "index_publishers_on_owner_id"

  create_table "publishers_users", :id => false, :force => true do |t|
    t.integer "publisher_id"
    t.integer "user_id"
  end

  add_index "publishers_users", ["publisher_id", "user_id"], :name => "index_publishers_users_on_publisher_id_and_user_id"
  add_index "publishers_users", ["publisher_id"], :name => "index_publishers_users_on_publisher_id"
  add_index "publishers_users", ["user_id"], :name => "index_publishers_users_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
