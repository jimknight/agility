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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121219104022) do

  create_table "attachments", :force => true do |t|
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"

  create_table "email_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "email_hierarchies", ["ancestor_id", "descendant_id"], :name => "index_email_hierarchies_on_ancestor_id_and_descendant_id", :unique => true
  add_index "email_hierarchies", ["descendant_id"], :name => "index_email_hierarchies_on_descendant_id"

  create_table "emails", :force => true do |t|
    t.text     "subject"
    t.text     "body"
    t.text     "sent_from"
    t.text     "sent_to"
    t.text     "copy_to"
    t.integer  "project_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "parent_id"
    t.integer  "emailable_id"
    t.string   "emailable_type"
    t.string   "email_type"
    t.text     "body_text"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "project_id"
    t.integer  "user_id"
  end

  create_table "note_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "note_hierarchies", ["ancestor_id", "descendant_id"], :name => "index_note_hierarchies_on_ancestor_id_and_descendant_id", :unique => true
  add_index "note_hierarchies", ["descendant_id"], :name => "index_note_hierarchies_on_descendant_id"

  create_table "notes", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "notable_id"
    t.string   "notable_type"
    t.integer  "parent_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects_stub_users", :force => true do |t|
    t.integer "project_id"
    t.integer "stub_user_id"
  end

  create_table "stub_users", :force => true do |t|
    t.string   "email"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "task_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "task_hierarchies", ["ancestor_id", "descendant_id"], :name => "index_task_hierarchies_on_ancestor_id_and_descendant_id", :unique => true
  add_index "task_hierarchies", ["descendant_id"], :name => "index_task_hierarchies_on_descendant_id"

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.date     "occurrence_date"
    t.integer  "taskable_id"
    t.string   "taskable_type"
    t.integer  "parent_id"
    t.integer  "project_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "status"
    t.date     "deadline"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "full_name"
    t.string   "provider"
    t.string   "uid"
    t.string   "image_url"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
