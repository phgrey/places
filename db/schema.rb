# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130402132136) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "cases", :force => true do |t|
    t.string  "source",     :limit => 100,                         :null => false
    t.string  "lang",       :limit => 2,   :default => "ru",       :null => false
    t.string  "r",          :limit => 100,                         :null => false
    t.string  "d",          :limit => 100,                         :null => false
    t.string  "v",          :limit => 100,                         :null => false
    t.string  "t",          :limit => 100,                         :null => false
    t.string  "p",          :limit => 100,                         :null => false
    t.string  "po",         :limit => 100,                         :null => false
    t.string  "where",      :limit => 100,                         :null => false
    t.string  "to",         :limit => 100,                         :null => false
    t.string  "from",       :limit => 100,                         :null => false
    t.string  "count",      :limit => 10,  :default => "singular", :null => false
    t.integer "parent_id",                                         :null => false
    t.integer "error_code",                                        :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "lang",       :default => "ru"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "categories", ["lang", "slug"], :name => "index_categories_on_lang_and_slug", :unique => true
  add_index "categories", ["lft"], :name => "index_categories_on_lft"
  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["rgt"], :name => "index_categories_on_rgt"

  create_table "cattings", :force => true do |t|
    t.integer "cattable_id"
    t.string  "cattable_type"
    t.integer "category_id"
  end

  add_index "cattings", ["category_id"], :name => "index_cattings_on_category_id"
  add_index "cattings", ["cattable_id", "cattable_type"], :name => "index_cattings_on_cattable_id_and_cattable_type"

  create_table "cities", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "lang",       :default => "ru"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "cities", ["lang", "slug"], :name => "index_cities_on_lang_and_slug", :unique => true

  create_table "downloads", :force => true do |t|
    t.integer  "parsetask_id"
    t.string   "url"
    t.text     "responce"
    t.text     "headers"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "downloads", ["parsetask_id"], :name => "index_downloads_on_parsetask_id"

  create_table "parsetasks", :force => true do |t|
    t.string   "source"
    t.string   "lang"
    t.integer  "parent_id"
    t.string   "external_ids"
    t.string   "path"
    t.integer  "children_found"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "parsetasks", ["lang", "item_id", "item_type"], :name => "index_parsetasks_on_lang_and_item_id_and_item_type"
  add_index "parsetasks", ["source", "lang", "path"], :name => "index_parsetasks_on_source_and_lang_and_path"

  create_table "places", :force => true do |t|
    t.string   "title"
    t.string   "lang"
    t.string   "latlng"
    t.integer  "city_id"
    t.text     "contacts"
    t.text     "content"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "places", ["lang", "id", "city_id"], :name => "index_places_on_lang_and_id_and_city_id"

  create_table "socials", :force => true do |t|
    t.integer  "user_id",                                                      :null => false
    t.string   "provider",                                                     :null => false
    t.decimal  "external_id", :precision => 10, :scale => 0,                   :null => false
    t.string   "rawdata"
    t.boolean  "public",                                     :default => true, :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  add_index "socials", ["external_id", "provider"], :name => "index_socials_on_external_id_and_provider", :unique => true
  add_index "socials", ["user_id", "public"], :name => "index_socials_on_user_id_and_public"

  create_table "synonyms", :primary_key => "s_id", :force => true do |t|
    t.string "keyword", :default => "", :null => false
    t.string "syn",     :default => "", :null => false
  end

  add_index "synonyms", ["keyword"], :name => "kkey"

  create_table "texts", :force => true do |t|
    t.text     "text"
    t.string   "lang"
    t.integer  "item_id"
    t.string   "item_type",  :default => "User"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "lang",                   :default => "en",  :null => false
    t.string   "photo"
    t.boolean  "habred",                 :default => false, :null => false
    t.integer  "options",                :default => 1
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
