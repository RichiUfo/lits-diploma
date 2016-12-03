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

ActiveRecord::Schema.define(version: 20161127205031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "city_source_types", force: :cascade do |t|
    t.integer  "city_id"
    t.integer  "source_type_id"
    t.integer  "ext_id"
    t.string   "ext_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["city_id"], name: "index_city_source_types_on_city_id", using: :btree
    t.index ["source_type_id"], name: "index_city_source_types_on_source_type_id", using: :btree
  end

  create_table "event_tags", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_tags_on_event_id", using: :btree
    t.index ["tag_id"], name: "index_event_tags_on_tag_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "city_id"
    t.integer  "organizer_id"
    t.integer  "category_id"
    t.integer  "source_id"
    t.integer  "format_id"
    t.datetime "date"
    t.float    "price"
    t.float    "lat"
    t.float    "lng"
    t.string   "ext_id"
    t.text     "name"
    t.string   "picture",      limit: 512
    t.text     "description"
    t.text     "address"
    t.text     "reg_ref"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "big_picture",  limit: 512
    t.string   "slug"
    t.index ["category_id"], name: "index_events_on_category_id", using: :btree
    t.index ["city_id"], name: "index_events_on_city_id", using: :btree
    t.index ["format_id"], name: "index_events_on_format_id", using: :btree
    t.index ["organizer_id"], name: "index_events_on_organizer_id", using: :btree
    t.index ["slug"], name: "index_events_on_slug", unique: true, using: :btree
    t.index ["source_id"], name: "index_events_on_source_id", using: :btree
  end

  create_table "formats", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "organizers", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "source_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
  end

  create_table "sources", force: :cascade do |t|
    t.integer  "source_type_id"
    t.text     "ref"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.bigint   "ext_id"
    t.integer  "city_id"
    t.index ["ext_id"], name: "index_sources_on_ext_id", using: :btree
    t.index ["source_type_id"], name: "index_sources_on_source_type_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_tags_on_slug", unique: true, using: :btree
  end

  create_table "user_feeds", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_user_feeds_on_category_id", using: :btree
    t.index ["user_id"], name: "index_user_feeds_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "image"
    t.string   "email",              default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "city_id"
    t.integer  "age"
    t.string   "name"
    t.string   "sex"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "provider"
    t.string   "uid"
    t.index ["city_id"], name: "index_users_on_city_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["provider"], name: "index_users_on_provider", using: :btree
    t.index ["uid"], name: "index_users_on_uid", using: :btree
  end

  add_foreign_key "city_source_types", "cities"
  add_foreign_key "city_source_types", "source_types"
  add_foreign_key "event_tags", "events"
  add_foreign_key "event_tags", "tags"
  add_foreign_key "events", "categories"
  add_foreign_key "events", "cities"
  add_foreign_key "events", "formats"
  add_foreign_key "events", "organizers"
  add_foreign_key "events", "sources"
  add_foreign_key "sources", "source_types"
  add_foreign_key "user_feeds", "categories"
  add_foreign_key "user_feeds", "users"
  add_foreign_key "users", "cities"
end
