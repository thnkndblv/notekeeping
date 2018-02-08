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

ActiveRecord::Schema.define(version: 20180207080456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notes", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.boolean "active", default: true, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tags", default: [], null: false, array: true
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "permission_types", primary_key: "permission", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shares", force: :cascade do |t|
    t.bigint "note_id"
    t.bigint "user_id"
    t.bigint "to_user_id", null: false
    t.string "permission", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id", "user_id", "to_user_id"], name: "index_shares_on_note_id_and_user_id_and_to_user_id", unique: true
    t.index ["note_id"], name: "index_shares_on_note_id"
    t.index ["user_id"], name: "index_shares_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "notes", "users"
  add_foreign_key "shares", "notes"
  add_foreign_key "shares", "permission_types", column: "permission", primary_key: "permission"
  add_foreign_key "shares", "users"
  add_foreign_key "shares", "users", column: "to_user_id"
end
