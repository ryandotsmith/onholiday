# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100130162928) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.string   "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holidays", :force => true do |t|
    t.integer  "user_id"
    t.integer  "state",        :default => 0
    t.string   "reviewed_by"
    t.datetime "reviewed_on"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.string   "leave_type"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "leave_length"
    t.string   "action_notes"
    t.string   "event_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "name"
    t.integer  "max_personal", :default => 10
    t.integer  "max_vacation", :default => 10
    t.integer  "max_etc",      :default => 10
    t.boolean  "is_admin",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date_of_hire"
  end

end
