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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161027223718) do

  create_table "requesters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "requester_id"
    t.string   "cat"
    t.string   "sbcat"
    t.string   "type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["requester_id"], name: "index_requests_on_requester_id", using: :btree
  end

  add_foreign_key "requests", "requesters"
end
