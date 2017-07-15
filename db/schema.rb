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

ActiveRecord::Schema.define(version: 20170715145818) do

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

  create_table "supports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sourceLanguage_id", null: false
    t.string "targetLanguage_id", null: false
    t.bigint "media_type_id", null: false
    t.index ["media_type_id"], name: "index_supports_on_media_type_id"
    t.index ["sourceLanguage_id"], name: "index_supports_on_sourceLanguage_id"
    t.index ["targetLanguage_id"], name: "index_supports_on_targetLanguage_id"
  end

  create_table "translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "context"
    t.bigint "support_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "targetWriting_id", null: false
    t.bigint "sourceWriting_id", null: false
    t.index ["sourceWriting_id"], name: "index_translations_on_sourceWriting_id"
    t.index ["support_id"], name: "index_translations_on_support_id"
    t.index ["targetWriting_id"], name: "index_translations_on_targetWriting_id"
  end

  create_table "writings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language_id"
    t.index ["language_id"], name: "index_writings_on_language_id"
  end

  add_foreign_key "supports", "languages", column: "sourceLanguage_id", primary_key: "code", name: "support_sourceLanguage_id_fk"
  add_foreign_key "supports", "languages", column: "targetLanguage_id", primary_key: "code", name: "support_targetLanguage_id_fk"
  add_foreign_key "supports", "media_types", name: "support_media_type_id_fk"
  add_foreign_key "translations", "supports", name: "translation_support_id_fk"
  add_foreign_key "translations", "writings", column: "sourceWriting_id", name: "translation_sourceWriting_id_fk"
  add_foreign_key "translations", "writings", column: "targetWriting_id", name: "translation_targetWriting_id_fk"
  add_foreign_key "writings", "languages", primary_key: "code", name: "writing_language_id_fk", on_update: :cascade
end
