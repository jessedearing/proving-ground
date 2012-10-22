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

ActiveRecord::Schema.define(:version => 20121021235035) do

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.datetime "publish_date"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_complete",  :default => false, :null => false
    t.boolean  "is_author",                       :null => false
  end

  add_index "comments", ["node_id"], :name => "index_comments_on_node_id"

  create_table "nodes", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "publish_date"
    t.boolean  "can_comment"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count"
  end

  add_index "nodes", ["publish_date"], :name => "index_nodes_on_publish_date"
  add_index "nodes", ["type"], :name => "index_nodes_on_type"

  create_table "users", :force => true do |t|
    t.string   "username",                           :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "failed_logins_count", :default => 0
    t.datetime "lock_expires_at"
    t.string   "unlock_token"
  end

end
