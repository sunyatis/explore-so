# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_19_164838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.text "namespace"
    t.text "body"
    t.text "resource_id"
    t.text "resource_type"
    t.bigint "author_id"
    t.text "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "idx_58344_index_active_admin_comments_on_author_type_and_author"
    t.index ["namespace"], name: "idx_58344_index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "idx_58344_index_active_admin_comments_on_resource_type_and_reso"
  end

  create_table "admin_users", force: :cascade do |t|
    t.text "email", default: ""
    t.text "encrypted_password", default: ""
    t.text "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text "current_sign_in_ip"
    t.text "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "idx_58332_index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "idx_58332_index_admin_users_on_reset_password_token", unique: true
  end

  create_table "catalogs", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "active", default: false
  end

  create_table "categories", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "catalog_id"
    t.text "title"
    t.text "code"
    t.text "description"
    t.bigint "credit"
    t.date "start_date"
    t.date "end_date"
    t.text "local_course_id"
    t.text "prefix"
    t.text "section"
    t.text "prerequisites"
    t.text "corequisites"
    t.text "books_url"
    t.text "registration_url"
    t.boolean "active"
    t.text "level"
    t.bigint "school_id"
    t.bigint "subjectarea_id"
    t.text "course_area"
    t.text "instructor"
    t.text "course_method"
    t.bigint "seats_available"
    t.boolean "class_full"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "generaleducation_id"
    t.text "slug"
    t.bigint "cat_id"
    t.index ["slug"], name: "idx_58456_index_courses_on_slug"
  end

  create_table "general_educations", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "level_abbs", force: :cascade do |t|
    t.text "name"
    t.text "description"
  end

  create_table "pathways", force: :cascade do |t|
    t.string "title"
    t.string "headline"
    t.string "description"
    t.string "learn_your_way_text"
    t.string "best_fit_link_1"
    t.string "best_fit_link_2"
    t.string "best_fit_link_3"
    t.string "meta_description"
    t.string "meta_keywords"
    t.string "page_title"
  end

  create_table "points_transactions", force: :cascade do |t|
    t.bigint "school_id"
    t.text "trans_type"
    t.bigint "points"
    t.bigint "payment"
    t.text "attendee"
    t.date "event_start"
    t.date "event_end"
    t.text "course"
    t.text "approved"
    t.text "points_type"
    t.text "trans_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "approver_comments"
  end

  create_table "programs", force: :cascade do |t|
    t.text "prog_title"
    t.text "description"
    t.text "subjectarea_id"
    t.text "prog_level"
    t.bigint "school_id"
    t.text "duration"
    t.text "delivery_method"
    t.text "open_suny"
    t.boolean "synchronous"
    t.boolean "tutoring"
    t.boolean "concierge"
    t.boolean "experiential_learning"
    t.boolean "plas"
    t.boolean "accelerated"
    t.text "level_expanded"
    t.bigint "sed"
    t.text "apply_now_url"
    t.text "slug"
    t.bigint "cat_id"
    t.text "ranku_id"
    t.boolean "active", default: true
    t.boolean "asynchronous"
    t.string "subject_area"
    t.string "subject_area_2"
    t.string "subject_area_3"
    t.text "meta_keywords"
    t.text "meta_desc"
    t.string "das_area"
    t.index ["slug"], name: "idx_58447_index_programs_on_slug", unique: true
  end

  create_table "schools", force: :cascade do |t|
    t.text "name"
    t.text "address1"
    t.text "address2"
    t.text "city"
    t.text "state"
    t.text "zip"
    t.text "school_url"
    t.text "registration_url"
    t.text "tuition_url"
    t.text "financial_aid_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "slug"
    t.text "image_file_name"
    t.text "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.string "campus_type"
    t.text "registrar_phone"
    t.string "abbv"
    t.index ["slug"], name: "idx_58429_index_schools_on_slug", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.text "session_id"
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "idx_58420_index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "idx_58420_index_sessions_on_updated_at"
  end

  create_table "subject_areas", force: :cascade do |t|
    t.text "name"
    t.index ["name"], name: "index_subject_areas_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.text "email", default: ""
    t.text "encrypted_password", default: ""
    t.text "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text "current_sign_in_ip"
    t.text "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "name"
    t.text "role"
    t.bigint "school_id"
  end

  create_table "versions", force: :cascade do |t|
    t.text "item_type"
    t.bigint "item_id"
    t.text "event"
    t.text "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "idx_58374_index_versions_on_item_type_and_item_id"
  end

end
