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

ActiveRecord::Schema.define(:version => 20121127220052) do

  create_table "cities", :force => true do |t|
    t.integer "state_id"
    t.string  "name"
  end

  add_index "cities", ["state_id"], :name => "index_cities_on_state_id"

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
