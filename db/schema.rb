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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140403175703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favmchars", force: true do |t|
    t.integer  "user_id"
    t.integer  "mchar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mchars", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "image_path"
    t.string   "image_ext"
    t.date     "modified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mchars_mcomics", id: false, force: true do |t|
    t.integer "mchar_id",  null: false
    t.integer "mcomic_id", null: false
  end

  create_table "mcomics", force: true do |t|
    t.integer  "mseries_id"
    t.integer  "mevent_id"
    t.string   "title"
    t.integer  "issueNumber"
    t.text     "description"
    t.text     "text"
    t.string   "url"
    t.string   "image_path"
    t.string   "image_ext"
    t.date     "onsaleDate"
    t.date     "focDate"
    t.date     "modified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mcomics", ["mseries_id"], name: "index_mcomics_on_mseries_id", using: :btree

  create_table "mreads", force: true do |t|
    t.integer  "user_id"
    t.integer  "mcomic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mserieses", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "startYear"
    t.integer  "endYear"
    t.string   "url"
    t.string   "image_path"
    t.string   "image_ext"
    t.date     "modified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.integer  "cc",                   default: 0
    t.string   "nick"
    t.boolean  "admin",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_file_name"
    t.string   "profile_content_type"
    t.integer  "profile_file_size"
    t.datetime "profile_updated_at"
  end

end
