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

ActiveRecord::Schema.define(version: 20151023040031) do

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "password_digest"
    t.string   "institution"
    t.string   "discipline"
    t.string   "school_of_study"
    t.string   "phone_number"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "remember_digest"
  end

  create_table "students_study_groups", id: false, force: :cascade do |t|
    t.integer "student_id"
    t.integer "study_group_id"
  end

  add_index "students_study_groups", ["student_id"], name: "index_students_study_groups_on_student_id"
  add_index "students_study_groups", ["study_group_id"], name: "index_students_study_groups_on_study_group_id"

  create_table "study_groups", force: :cascade do |t|
    t.string   "title"
    t.string   "topic"
    t.string   "institution"
    t.integer  "student_limit"
    t.integer  "admin_student_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "study_sessions", force: :cascade do |t|
    t.string   "location"
    t.time     "start_time"
    t.time     "end_time"
    t.date     "day"
    t.integer  "study_group_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "notes"
  end

end
