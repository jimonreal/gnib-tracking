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

ActiveRecord::Schema.define(version: 20161030223908) do

  create_table "availabilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cat_id"
    t.integer  "typ_id"
    t.datetime "datetime"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "expired",    default: false
    t.index ["cat_id"], name: "index_availabilities_on_cat_id", using: :btree
    t.index ["typ_id"], name: "index_availabilities_on_typ_id", using: :btree
  end

  create_table "cats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sbcats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "cat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cat_id"], name: "index_sbcats_on_cat_id", using: :btree
  end

  create_table "trackings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cat_id"
    t.integer  "sbcat_id"
    t.integer  "typ_id"
    t.index ["cat_id"], name: "index_trackings_on_cat_id", using: :btree
    t.index ["sbcat_id"], name: "index_trackings_on_sbcat_id", using: :btree
    t.index ["typ_id"], name: "index_trackings_on_typ_id", using: :btree
    t.index ["user_id"], name: "index_trackings_on_user_id", using: :btree
  end

  create_table "typs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_foreign_key "sbcats", "cats"
  add_foreign_key "trackings", "cats"
  add_foreign_key "trackings", "sbcats"
  add_foreign_key "trackings", "typs"
  add_foreign_key "trackings", "users"
end
