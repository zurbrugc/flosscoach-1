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

ActiveRecord::Schema.define(version: 20161018043454) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operating_systems", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "project_page_url"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "language_id"
    t.integer  "tool_id"
    t.integer  "operational_system_id"
    t.text     "about"
    t.text     "technical_skill"
    t.text     "soft_skill"
    t.text     "contribution"
    t.text     "workspace_setup"
    t.text     "resource"
    t.text     "documentation"
    t.text     "search_resource"
    t.text     "send_contribution"
    t.text     "link"
    t.string   "image_url"
  end

  add_index "projects", ["language_id"], name: "index_projects_on_language_id"
  add_index "projects", ["operational_system_id"], name: "index_projects_on_operational_system_id"
  add_index "projects", ["tool_id"], name: "index_projects_on_tool_id"

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "projects_users", ["project_id", "user_id"], name: "index_projects_users_on_project_id_and_user_id"

  create_table "tools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.date     "birth"
    t.string   "email"
    t.string   "username"
    t.string   "encrypted_password"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_url"
    t.string   "fb_token"
    t.string   "provider"
    t.string   "uid"
    t.string   "description"
    t.boolean  "email_confirmed"
    t.string   "confirm_token"
    t.boolean  "admin"
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
  end

end
