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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111118204320) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.string   "place"
    t.string   "leader"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.string   "identificator_number"
    t.string   "formation"
  end

  create_table "activities_participants", :id => false, :force => true do |t|
    t.integer  "activity_id",    :null => false
    t.integer  "participant_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities_participants", ["activity_id", "participant_id"], :name => "index_activities_participants_on_activity_id_and_participant_id"

  create_table "certificates", :force => true do |t|
    t.string   "period"
    t.integer  "total_hours"
    t.integer  "frequency"
    t.string   "file_path"
    t.integer  "participant_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identifier"
    t.text     "description"
    t.boolean  "certificates_generated",    :default => false
    t.string   "reference_code"
    t.text     "identifier_to_certificate"
  end

  create_table "participants", :force => true do |t|
    t.string   "name"
    t.string   "group"
    t.string   "unit"
    t.string   "contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id",  :null => false
    t.string   "list"
  end

  create_table "tmp_participants", :force => true do |t|
    t.integer "participant_id"
    t.integer "course_id"
    t.string  "unit"
    t.string  "p_group"
    t.string  "contact"
    t.string  "name"
  end

end
