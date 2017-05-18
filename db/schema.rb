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

ActiveRecord::Schema.define(version: 20170518003812) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_projects", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "project_id",  null: false
    t.index ["category_id", "project_id"], name: "index_categories_projects_on_category_id_and_project_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "reply_to_id"
    t.integer  "user_id"
    t.integer  "widget_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "default_tips", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "widget_slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "favoriter_projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
    t.integer  "user_id"
  end

  create_table "forums", force: :cascade do |t|
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_hub_data", force: :cascade do |t|
    t.integer  "open_hub_id"
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.string   "homepage_url"
    t.string   "logo_url"
    t.string   "vanity_url"
    t.string   "download_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "operating_systems", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owner_projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
    t.integer  "user_id"
  end

  create_table "pics", force: :cascade do |t|
    t.string   "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "project_page_url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_url"
    t.string   "avatar"
    t.boolean  "use_open_hub_image"
    t.string   "open_hub_image_url"
    t.boolean  "use_open_hub_data"
    t.integer  "open_hub_id"
  end

  create_table "projects_tags", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "tag_id",     null: false
    t.index ["project_id", "tag_id"], name: "index_projects_tags_on_project_id_and_tag_id"
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_topics", id: false, force: :cascade do |t|
    t.integer "tag_id",   null: false
    t.integer "topic_id", null: false
    t.index ["tag_id", "topic_id"], name: "index_tags_topics_on_tag_id_and_topic_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "forum_id"
    t.string   "title"
    t.boolean  "locked"
    t.datetime "locked_at"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "content"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.date     "birth"
    t.string   "email"
    t.string   "username"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "fb_token"
    t.string   "provider"
    t.string   "uid"
    t.string   "description"
    t.boolean  "email_confirmed"
    t.string   "confirm_token"
    t.boolean  "admin"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "twitter_link"
    t.string   "facebook_link"
    t.string   "github_link"
    t.string   "avatar"
    t.string   "slug"
    t.string   "password"
    t.string   "password_digest"
    t.string   "twitter_username"
    t.string   "facebook_username"
    t.string   "github_username"
    t.index ["email"], name: "index_users_on_email"
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "widgets", force: :cascade do |t|
    t.string   "title",                      null: false
    t.string   "tab",                        null: false
    t.string   "slug"
    t.integer  "pos_x",                      null: false
    t.integer  "pos_y",                      null: false
    t.integer  "width",                      null: false
    t.integer  "height",                     null: false
    t.boolean  "closeable",   default: true
    t.boolean  "resizeable",  default: true
    t.boolean  "retractable", default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "content"
    t.integer  "project_id"
    t.boolean  "deletable",   default: true
  end

end
