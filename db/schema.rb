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

ActiveRecord::Schema.define(version: 20151229062546) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "song_id",           limit: 4
    t.text     "comment",           limit: 65535
    t.string   "link",              limit: 255
    t.string   "role",              limit: 255
    t.string   "status",            limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.datetime "logo_updated_at"
  end

  add_index "comments", ["song_id"], name: "index_comments_on_song_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id",   limit: 4
    t.integer  "user_id",             limit: 4
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message",             limit: 65535
    t.text     "referrer",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: {"impressionable_type"=>nil, "message"=>255, "impressionable_id"=>nil}, using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "likings", force: :cascade do |t|
    t.integer  "song_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "likings", ["song_id"], name: "index_likings_on_song_id", using: :btree
  add_index "likings", ["user_id"], name: "index_likings_on_user_id", using: :btree

  create_table "mains", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "username",          limit: 255
    t.integer  "user_id",           limit: 4
    t.string   "location",          limit: 255
    t.string   "status",            limit: 255
    t.string   "image",             limit: 255
    t.string   "role",              limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "nickname",          limit: 255
    t.text     "about",             limit: 65535
    t.string   "job",               limit: 255
    t.string   "gender",            limit: 255
    t.string   "birthday",          limit: 255
    t.string   "age",               limit: 255
    t.string   "locale",            limit: 255
    t.string   "fb_link",           limit: 255
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.datetime "logo_updated_at"
  end

  add_index "profiles", ["location"], name: "index_profiles_on_location", using: :btree
  add_index "profiles", ["role"], name: "index_profiles_on_role", using: :btree
  add_index "profiles", ["status"], name: "index_profiles_on_status", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "singer",         limit: 255
    t.text     "introduction",   limit: 65535
    t.string   "link",           limit: 255
    t.string   "picture",        limit: 255
    t.integer  "views_count",    limit: 4
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "likings_count",  limit: 4,     default: 0
    t.string   "use",            limit: 255,   default: "hide"
    t.string   "teacher_choice", limit: 255
  end

  add_index "songs", ["user_id"], name: "index_songs_on_user_id", using: :btree

  create_table "star_records", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "song_id",          limit: 4
    t.string   "action",           limit: 255
    t.string   "status",           limit: 255
    t.integer  "free_star_count",  limit: 4
    t.integer  "money_star_count", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "picture",                limit: 255
    t.text     "about",                  limit: 65535
    t.string   "address",                limit: 255
    t.string   "fb_uid",                 limit: 255
    t.string   "fb_token",               limit: 255
    t.integer  "likings_count",          limit: 4,     default: 0
    t.string   "fb_image",               limit: 255
    t.string   "gender",                 limit: 255
    t.string   "birthday",               limit: 255
    t.string   "location",               limit: 255
    t.string   "job",                    limit: 255
    t.string   "locale",                 limit: 255
    t.string   "fb_link",                limit: 255
    t.text     "fb_raw",                 limit: 65535
    t.text     "fb_extra",               limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comments", "songs"
  add_foreign_key "comments", "users"
  add_foreign_key "songs", "users"
end
