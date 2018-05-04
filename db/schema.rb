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

ActiveRecord::Schema.define(version: 20180504214004) do

  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "question_id"
    t.boolean "correct"
    t.bigint "review_id"
    t.bigint "writing_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["review_id"], name: "index_answers_on_review_id"
    t.index ["writing_id"], name: "index_answers_on_writing_id"
  end

  create_table "languages", primary_key: "code", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "sqlite_autoindex_languages_1", unique: true
  end

  create_table "media_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "question"
    t.bigint "review_id"
    t.bigint "translation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "writing_id"
    t.boolean "reverse"
    t.boolean "correctly_answered", default: false
    t.index ["review_id"], name: "index_questions_on_review_id"
    t.index ["translation_id"], name: "index_questions_on_translation_id"
    t.index ["writing_id"], name: "index_questions_on_writing_id"
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "support_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "complete", default: false
    t.float "mark", limit: 24, default: 0.0
    t.index ["support_id"], name: "index_reviews_on_support_id"
  end

  create_table "supports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sourceLanguage_id", null: false
    t.string "targetLanguage_id", null: false
    t.bigint "media_type_id", null: false
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.datetime "archive_at"
    t.float "mark", limit: 24, default: 0.0
    t.index ["media_type_id"], name: "index_supports_on_media_type_id"
    t.index ["sourceLanguage_id"], name: "index_supports_on_sourceLanguage_id"
    t.index ["targetLanguage_id"], name: "index_supports_on_targetLanguage_id"
    t.index ["user_id"], name: "index_supports_on_user_id"
  end

  create_table "translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "context"
    t.bigint "support_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "targetWriting_id", null: false
    t.bigint "sourceWriting_id", null: false
    t.datetime "deleted_at"
    t.index ["sourceWriting_id"], name: "index_translations_on_sourceWriting_id"
    t.index ["support_id"], name: "index_translations_on_support_id"
    t.index ["targetWriting_id"], name: "index_translations_on_targetWriting_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "writings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language_id"
    t.index ["language_id"], name: "index_writings_on_language_id"
    t.index ["text", "language_id"], name: "index_writings_on_text_and_language_id", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "reviews"
  add_foreign_key "answers", "writings"
  add_foreign_key "questions", "reviews"
  add_foreign_key "questions", "translations"
  add_foreign_key "questions", "writings"
  add_foreign_key "reviews", "supports"
  add_foreign_key "supports", "languages", column: "sourceLanguage_id", primary_key: "code", name: "support_sourceLanguage_id_fk", on_update: :cascade
  add_foreign_key "supports", "languages", column: "targetLanguage_id", primary_key: "code", name: "support_targetLanguage_id_fk", on_update: :cascade
  add_foreign_key "supports", "media_types", name: "support_media_type_id_fk"
  add_foreign_key "supports", "users"
  add_foreign_key "translations", "supports", name: "translation_support_id_fk"
  add_foreign_key "translations", "writings", column: "sourceWriting_id", name: "translation_sourceWriting_id_fk"
  add_foreign_key "translations", "writings", column: "targetWriting_id", name: "translation_targetWriting_id_fk"
  add_foreign_key "writings", "languages", primary_key: "code", name: "writing_language_id_fk", on_update: :cascade
end
