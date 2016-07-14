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

ActiveRecord::Schema.define(version: 20160714214533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rendered_content_items", force: :cascade do |t|
    t.text     "content"
    t.string   "checksum"
    t.string   "pipeline"
    t.integer  "source_content_item_id"
    t.string   "version"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["source_content_item_id"], name: "index_rendered_content_items_on_source_content_item_id", using: :btree
  end

  create_table "source_content_items", force: :cascade do |t|
    t.text     "content"
    t.string   "checksum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "rendered_content_items", "source_content_items"
end
