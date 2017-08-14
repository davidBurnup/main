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

ActiveRecord::Schema.define(version: 20170814085753) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_draft"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50,    default: ""
    t.text     "comment",          limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "creator_id",       limit: 4
    t.string   "role",             limit: 255,   default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updater_id",       limit: 4
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["creator_id"], name: "index_comments_on_creator_id", using: :btree

  create_table "follows", force: :cascade do |t|
    t.string   "follower_type",   limit: 255
    t.integer  "follower_id",     limit: 4
    t.string   "followable_type", limit: 255
    t.integer  "followable_id",   limit: 4
    t.datetime "created_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "instrument_preferences", force: :cascade do |t|
    t.integer  "instrument", limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "detail",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: :cascade do |t|
    t.string   "liker_type",    limit: 255
    t.integer  "liker_id",      limit: 4
    t.string   "likeable_type", limit: 255
    t.integer  "likeable_id",   limit: 4
    t.datetime "created_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "fk_likeables", using: :btree
  add_index "likes", ["liker_id", "liker_type"], name: "fk_likes", using: :btree

  create_table "media", force: :cascade do |t|
    t.integer  "post_id",                 limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size",    limit: 4
    t.datetime "attachment_updated_at"
  end

  create_table "medias", force: :cascade do |t|
    t.integer  "post_id",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "pdf_file_name",      limit: 255
    t.string   "pdf_content_type",   limit: 255
    t.integer  "pdf_file_size",      limit: 4
    t.datetime "pdf_updated_at"
    t.string   "word_file_name",     limit: 255
    t.string   "word_content_type",  limit: 255
    t.integer  "word_file_size",     limit: 4
    t.datetime "word_updated_at"
    t.string   "excel_file_name",    limit: 255
    t.string   "excel_content_type", limit: 255
    t.integer  "excel_file_size",    limit: 4
    t.datetime "excel_updated_at"
    t.string   "audio_file_name",    limit: 255
    t.string   "audio_content_type", limit: 255
    t.integer  "audio_file_size",    limit: 4
    t.datetime "audio_updated_at"
  end

  create_table "meeting_songs", force: :cascade do |t|
    t.integer  "song_id",    limit: 4
    t.integer  "meeting_id", limit: 4
    t.integer  "leader_id",  limit: 4
    t.string   "key",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meeting_users", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "meeting_id",   limit: 4
    t.integer  "instrument",   limit: 4
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_leader"
    t.boolean  "is_co_leader"
    t.boolean  "was_notified"
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "label",      limit: 255
    t.datetime "start_at"
    t.integer  "duration",   limit: 4
    t.integer  "created_by", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "songs",      limit: 65535
    t.integer  "creator_id", limit: 4
    t.integer  "updater_id", limit: 4
  end

  create_table "mentions", force: :cascade do |t|
    t.string   "mentioner_type",   limit: 255
    t.integer  "mentioner_id",     limit: 4
    t.string   "mentionable_type", limit: 255
    t.integer  "mentionable_id",   limit: 4
    t.datetime "created_at"
  end

  add_index "mentions", ["mentionable_id", "mentionable_type"], name: "fk_mentionables", using: :btree
  add_index "mentions", ["mentioner_id", "mentioner_type"], name: "fk_mentions", using: :btree

  create_table "notes", force: :cascade do |t|
    t.integer  "song_id",    limit: 4
    t.integer  "line",       limit: 4
    t.integer  "offset",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "note",       limit: 255
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "notifiable_type", limit: 255
    t.integer  "notifiable_id",   limit: 4
    t.integer  "notifier_id",     limit: 4
    t.integer  "notified_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_seen"
    t.datetime "deleted_at"
  end

  add_index "notifications", ["deleted_at"], name: "index_notifications_on_deleted_at", using: :btree

  create_table "page_roles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "role",       limit: 4
    t.integer  "page_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_valid"
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.string   "address",             limit: 255
    t.float    "latitude",            limit: 24
    t.float    "longitude",           limit: 24
    t.integer  "creator_id",          limit: 4
    t.integer  "updater_id",          limit: 4
    t.string   "slogan",              limit: 255
  end

  create_table "posts", force: :cascade do |t|
    t.text     "content",      limit: 65535
    t.integer  "user_id",      limit: 4
    t.integer  "song_id",      limit: 4
    t.string   "external_url", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id",   limit: 4
    t.integer  "updater_id",   limit: 4
    t.boolean  "is_draft"
  end

  create_table "practice_users", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "practice_id", limit: 4
    t.boolean  "accepted"
    t.boolean  "notified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "practices", force: :cascade do |t|
    t.integer  "meeting_id", limit: 4
    t.datetime "start_at"
    t.integer  "duration",   limit: 4
    t.integer  "reminder",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "content",          limit: 65535
    t.string   "key",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transposed_key",   limit: 255
    t.integer  "transpose_offset", limit: 4
    t.string   "note",             limit: 255
    t.text     "clean_content",    limit: 65535
    t.string   "author",           limit: 255
    t.integer  "created_by",       limit: 4
    t.integer  "origin_page_id",   limit: 4
    t.integer  "bpm",              limit: 4
    t.integer  "creator_id",       limit: 4
    t.integer  "updater_id",       limit: 4
  end

  add_index "songs", ["clean_content"], name: "clean_content_full_text", type: :fulltext

  create_table "user_devices", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "endpoint",      limit: 255
    t.string   "auth",          limit: 255
    t.string   "p256dh",        limit: 255
    t.boolean  "vapid_enabled"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "expired"
  end

  create_table "user_song_preferences", force: :cascade do |t|
    t.integer  "song_id",       limit: 4
    t.integer  "user_id",       limit: 4
    t.string   "prefered_key",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prefered_capo", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "role",                   limit: 4
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       limit: 4
    t.integer  "invited_by_id",          limit: 4
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",      limit: 4,   default: 0
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.integer  "page_id",                limit: 4
    t.boolean  "is_finalized"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
