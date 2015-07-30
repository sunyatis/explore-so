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

ActiveRecord::Schema.define(version: 20150730134926) do

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

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "catalogs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "active",     default: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "catalog_id"
    t.string   "title"
    t.string   "code"
    t.text     "description"
    t.integer  "credit"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "local_course_id"
    t.string   "prefix"
    t.string   "section"
    t.text     "prerequisites"
    t.text     "corequisites"
    t.string   "books_url"
    t.string   "registration_url"
    t.boolean  "active"
    t.string   "level"
    t.integer  "school_id"
    t.integer  "subjectarea_id"
    t.string   "course_area"
    t.string   "instructor"
    t.string   "course_method"
    t.integer  "seats_available"
    t.boolean  "class_full"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "generaleducation_id"
    t.text     "slug"
  end

  add_index "courses", ["slug"], name: "index_courses_on_slug"

  create_table "general_educations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "level_abbs", force: :cascade do |t|
    t.string "name"
    t.string "description"
  end

  create_table "points_transactions", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "trans_type"
    t.integer  "points"
    t.integer  "payment"
    t.string   "attendee"
    t.date     "event_start"
    t.date     "event_end"
    t.string   "course"
    t.string   "approved"
    t.string   "points_type"
    t.string   "trans_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "approver_comments"
  end

  create_table "programs", force: :cascade do |t|
    t.string  "prog_title"
    t.text    "description"
    t.integer "subjectarea_id"
    t.string  "prog_level"
    t.integer "levelabb_id"
    t.integer "school_id"
    t.string  "duration"
    t.string  "delivery_method"
    t.text    "prerequisites"
    t.string  "program_url"
    t.string  "registration_url"
    t.string  "open_suny"
    t.string  "per_courses_online"
    t.boolean "synchronous"
    t.string  "synchronous_text"
    t.boolean "tutoring"
    t.string  "tutoring_name"
    t.string  "tutoring_phone"
    t.string  "tutoring_email"
    t.string  "tutoring_url"
    t.boolean "helpdesk"
    t.string  "helpdesk_phone"
    t.string  "helpdesk_email"
    t.string  "helpdesk_url"
    t.boolean "concierge"
    t.string  "concierge_phone"
    t.string  "concierge_name"
    t.string  "concierge_email"
    t.boolean "experiential_learning"
    t.text    "experiential_text"
    t.boolean "plas"
    t.text    "plas_text"
    t.boolean "accelerated"
    t.text    "accelerated_text"
    t.text    "summary"
    t.string  "level_expanded"
    t.integer "sed"
    t.string  "apply_now_url"
    t.text    "slug"
  end

  add_index "programs", ["slug"], name: "index_programs_on_slug", unique: true

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "school_url"
    t.string   "registration_url"
    t.string   "tuition_url"
    t.string   "financial_aid_url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "schools", ["slug"], name: "index_schools_on_slug", unique: true

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "subject_areas", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "role"
    t.integer  "school_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
