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

ActiveRecord::Schema.define(:version => 20120727153923) do

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
  add_index "categories", ["rgt"], :name => "index_categories_on_rgt"

  create_table "cattings", :force => true do |t|
    t.integer "cattable_id"
    t.string  "cattable_type"
    t.integer "category_id"
    t.string  "category_type", :default => "Category", :null => false
  end

  add_index "cattings", ["category_id", "category_type"], :name => "index_cattings_on_category_id_and_category_type"
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

  create_table "offers", :force => true do |t|
    t.text     "description"
    t.integer  "hours"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

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

  create_table "socials", :force => true do |t|
    t.integer  "user_id",                                                      :null => false
    t.string   "provider",                                                     :null => false
    t.decimal  "external_id", :precision => 22, :scale => 0,                   :null => false
    t.string   "rawdata"
    t.boolean  "public",                                     :default => true, :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  add_index "socials", ["external_id", "provider"], :name => "index_socials_on_external_id_and_provider", :unique => true
  add_index "socials", ["user_id", "public"], :name => "index_socials_on_user_id_and_public"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "texts", :force => true do |t|
    t.text     "text"
    t.string   "lang"
    t.integer  "item_id"
    t.string   "item_type",  :default => "Offer"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email",                  :default => ""
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
