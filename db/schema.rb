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

ActiveRecord::Schema.define(:version => 20130408035536) do

  create_table "cities", :force => true do |t|
    t.integer "state_id"
    t.string  "name"
  end

  add_index "cities", ["state_id"], :name => "index_cities_on_state_id"

  create_table "credentials", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.string   "provider",                   :null => false
    t.string   "uid",                        :null => false
    t.string   "name",       :default => ""
    t.string   "email",      :default => ""
    t.text     "info",       :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "credentials", ["email"], :name => "index_credentials_on_email"
  add_index "credentials", ["provider", "uid"], :name => "index_credentials_on_provider_and_uid"
  add_index "credentials", ["user_id"], :name => "index_credentials_on_user_id"

  create_table "identities", :force => true do |t|
    t.string   "name",            :default => ""
    t.string   "email",                           :null => false
    t.string   "password_digest",                 :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "identities", ["email"], :name => "index_identities_on_email"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "location"
    t.string   "identification"
    t.string   "activity"
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "duration"
    t.integer  "delay"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "states", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
