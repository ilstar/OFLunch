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

ActiveRecord::Schema.define(:version => 20120906074844) do

  create_table "balance_logs", :force => true do |t|
    t.integer  "balance_id"
    t.decimal  "amount",     :precision => 10, :scale => 2
    t.integer  "order_id"
    t.string   "operation"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "balances", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "amount",     :precision => 10, :scale => 2
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "meal_times", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "status"
  end

  create_table "menu_items", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "vendor_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.datetime "deleted_at"
    t.integer  "category_id"
    t.float    "average_rating"
  end

  add_index "menu_items", ["category_id"], :name => "index_menu_items_on_category_id"

  create_table "menu_of_meals", :force => true do |t|
    t.integer  "vendor_id"
    t.integer  "meal_time_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "recipient_id"
    t.boolean  "read",         :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "entity_type",                     :null => false
    t.integer  "entity_id",                       :null => false
  end

  add_index "messages", ["entity_type", "entity_id"], :name => "index_messages_on_entity_type_and_entity_id"

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "menu_item_id"
    t.float    "price"
    t.integer  "amount"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "rating"
    t.text     "comment"
  end

  create_table "orders", :force => true do |t|
    t.integer  "meal_time_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "name"
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
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "deleted_at"
  end

end
