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

ActiveRecord::Schema.define(version: 20190917133033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_stat_statements"
  enable_extension "postgis"
  enable_extension "tablefunc"

  create_table "arsiv_approvals", force: :cascade do |t|
    t.string   "reference",         limit: 30,                      null: false
    t.integer  "parent_id",                                         null: false
    t.string   "parent_type",                                       null: false
    t.integer  "user_id",                                           null: false
    t.string   "approval_status",   limit: 20,  default: "pending"
    t.integer  "approver_id"
    t.datetime "approval_datetime"
    t.integer  "patron_id",                                         null: false
    t.string   "notes",             limit: 500
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "parent_title",      limit: 100
    t.string   "approval_type",     limit: 20
    t.index ["parent_type", "parent_id"], name: "index_arsiv_approvals_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_arsiv_approvals_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_approvals_on_user_id", using: :btree
  end

  create_table "arsiv_approvals_users", force: :cascade do |t|
    t.integer  "approval_id", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["approval_id"], name: "index_arsiv_approvals_users_on_approval_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_approvals_users_on_user_id", using: :btree
  end

  create_table "arsiv_audits", force: :cascade do |t|
    t.string   "action_type",    limit: 10, null: false
    t.string   "parent_type"
    t.integer  "parent_id"
    t.json     "changed_fields"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["parent_type", "parent_id"], name: "index_arsiv_audits_on_parent_type_and_parent_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_audits_on_user_id", using: :btree
  end

  create_table "arsiv_coin_actions", force: :cascade do |t|
    t.string   "service_code", limit: 30,                 null: false
    t.string   "reference",    limit: 50
    t.string   "parent_type",  limit: 50
    t.integer  "parent_id"
    t.decimal  "debit",                   default: "0.0"
    t.decimal  "credit",                  default: "0.0"
    t.integer  "user_id"
    t.integer  "patron_id",                               null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "arsiv_coin_stats", force: :cascade do |t|
    t.string   "service_code", limit: 30,                 null: false
    t.integer  "patron_id",                               null: false
    t.decimal  "balance",                 default: "0.0"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

# Could not dump table "arsiv_country_locations" because of following StandardError
#   Unknown type 'geography(Point,4326)' for column 'geog'

  create_table "arsiv_coupons", force: :cascade do |t|
    t.string   "code",        limit: 10,                    null: false
    t.string   "parent_type"
    t.integer  "parent_id"
    t.string   "status",      limit: 10, default: "active", null: false
    t.date     "due_date"
    t.integer  "patron_id",                                 null: false
    t.integer  "user_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.decimal  "amount",                 default: "0.0"
    t.string   "curr",        limit: 3
    t.index ["parent_type", "parent_id"], name: "index_arsiv_coupons_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_arsiv_coupons_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_coupons_on_user_id", using: :btree
  end

  create_table "arsiv_dispatch_lines", force: :cascade do |t|
    t.integer  "dispatch_id",                              null: false
    t.string   "name",         limit: 120,                 null: false
    t.string   "unit_number",  limit: 255, default: "1"
    t.string   "unit_type",    limit: 30
    t.decimal  "unit_price",               default: "0.0"
    t.string   "curr",         limit: 3
    t.decimal  "total_amount",             default: "0.0"
    t.text     "notes"
    t.integer  "patron_id",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["dispatch_id"], name: "index_arsiv_dispatch_lines_on_dispatch_id", using: :btree
  end

  create_table "arsiv_dispatches", force: :cascade do |t|
    t.string   "reference",            limit: 30,              null: false
    t.integer  "company_id"
    t.string   "doc_no",               limit: 30
    t.date     "doc_date",                                     null: false
    t.date     "oper_date"
    t.date     "deliver_date"
    t.string   "invoice_no",           limit: 30
    t.string   "company_name",         limit: 120,             null: false
    t.text     "company_address"
    t.string   "company_city",         limit: 40
    t.string   "company_country_id",   limit: 2
    t.string   "company_taxoffice",    limit: 100
    t.string   "company_taxno",        limit: 20
    t.string   "edited_by",            limit: 60
    t.string   "deliver_to",           limit: 60
    t.text     "oper_notes"
    t.text     "notes"
    t.integer  "parent_id"
    t.string   "parent_type",          limit: 255
    t.integer  "dispatch_lines_count",             default: 0
    t.integer  "comments_count",                   default: 0
    t.integer  "user_id",                                      null: false
    t.integer  "branch_id",                                    null: false
    t.integer  "patron_id",                                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["company_id"], name: "index_arsiv_dispatches_on_company_id", using: :btree
    t.index ["parent_id", "parent_type"], name: "index_arsiv_dispatches_on_parent_id_and_parent_type", using: :btree
  end

  create_table "arsiv_docfiles", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.integer  "document_id"
    t.string   "doc_file",    limit: 255, null: false
    t.integer  "user_id",                 null: false
    t.integer  "patron_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "email_id"
    t.string   "parent_type", limit: 30
    t.integer  "parent_id"
    t.integer  "group_id"
    t.text     "s3file_data"
    t.index ["document_id"], name: "index_arsiv_docfiles_on_document_id", using: :btree
    t.index ["email_id"], name: "index_arsiv_docfiles_on_email_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_arsiv_docfiles_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_arsiv_docfiles_on_patron_id", using: :btree
  end

  create_table "arsiv_docimport_templatelines", force: :cascade do |t|
    t.integer  "docimport_template_id",             null: false
    t.string   "col_type",              limit: 100
    t.string   "col_title",             limit: 100
    t.string   "reference_type",        limit: 100
    t.string   "reference_col",         limit: 100
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "col_number",                        null: false
    t.integer  "max_length"
  end

  create_table "arsiv_docimport_templates", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "user_id"
    t.string   "parent",                    null: false
    t.string   "title"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "fixed_values", limit: 1000
    t.index ["patron_id"], name: "index_arsiv_docimport_templates_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_docimport_templates_on_user_id", using: :btree
  end

  create_table "arsiv_docimportlines", force: :cascade do |t|
    t.integer  "patron_id",                                    null: false
    t.integer  "user_id",                                      null: false
    t.integer  "docimport_id",                                 null: false
    t.string   "doc_type",     limit: 100
    t.string   "line_type",    limit: 100
    t.string   "status",       limit: 10,  default: "pending"
    t.text     "note"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "col0",         limit: 255
    t.string   "col1",         limit: 255
    t.string   "col2",         limit: 255
    t.string   "col3",         limit: 255
    t.string   "col4",         limit: 255
    t.string   "col5",         limit: 255
    t.string   "col6",         limit: 255
    t.string   "col7",         limit: 255
    t.string   "col8",         limit: 255
    t.string   "col9",         limit: 255
    t.string   "col10",        limit: 255
    t.string   "col11",        limit: 255
    t.string   "col12",        limit: 255
    t.string   "col13",        limit: 255
    t.string   "col14",        limit: 255
    t.string   "col15",        limit: 255
    t.string   "col16",        limit: 255
    t.string   "col17",        limit: 255
    t.string   "col18",        limit: 255
    t.string   "col19",        limit: 255
    t.string   "col20",        limit: 255
    t.string   "col21",        limit: 255
    t.string   "col22",        limit: 255
    t.string   "col23",        limit: 255
    t.string   "col24",        limit: 255
    t.string   "col25",        limit: 255
    t.string   "col26",        limit: 255
    t.string   "col27",        limit: 255
    t.string   "col28",        limit: 255
    t.string   "col29",        limit: 255
    t.string   "col30",        limit: 255
    t.string   "col31",        limit: 255
    t.string   "col32",        limit: 255
    t.string   "col33",        limit: 255
    t.string   "col34",        limit: 255
    t.string   "col35",        limit: 255
    t.string   "col36",        limit: 255
    t.string   "col37",        limit: 255
    t.string   "col38",        limit: 255
    t.string   "col39",        limit: 255
    t.string   "col40",        limit: 255
    t.string   "col41",        limit: 255
    t.string   "col42",        limit: 255
    t.string   "col43",        limit: 255
    t.string   "col44",        limit: 255
    t.string   "col45",        limit: 255
    t.string   "col46",        limit: 255
    t.string   "col47",        limit: 255
    t.string   "col48",        limit: 255
    t.string   "col49",        limit: 255
    t.string   "col50",        limit: 255
    t.string   "uuid",         limit: 50
  end

  create_table "arsiv_docimports", force: :cascade do |t|
    t.string   "doc_type",              limit: 100,                     null: false
    t.string   "import_file",           limit: 255,                     null: false
    t.integer  "user_id"
    t.integer  "patron_id"
    t.integer  "total_lines"
    t.integer  "imported_lines"
    t.string   "status",                limit: 10,  default: "pending"
    t.text     "notes"
    t.text     "system_msg"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "docimport_template_id"
    t.hstore   "fixed_values"
    t.string   "uuid",                  limit: 50
    t.index ["doc_type"], name: "index_arsiv_docimports_on_doc_type", using: :btree
    t.index ["patron_id"], name: "index_arsiv_docimports_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_docimports_on_user_id", using: :btree
  end

  create_table "arsiv_doctemplates", force: :cascade do |t|
    t.string   "name",       limit: 100, null: false
    t.string   "doc_type",   limit: 50,  null: false
    t.string   "doc_logo"
    t.string   "notes",      limit: 255
    t.integer  "user_id",                null: false
    t.integer  "patron_id",              null: false
    t.hstore   "attr"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["doc_type"], name: "index_arsiv_doctemplates_on_doc_type", using: :btree
    t.index ["patron_id"], name: "index_arsiv_doctemplates_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_doctemplates_on_user_id", using: :btree
  end

  create_table "arsiv_documents", force: :cascade do |t|
    t.string   "name",            limit: 255,                    null: false
    t.date     "document_date"
    t.string   "document_no",     limit: 255
    t.string   "documented_type", limit: 100
    t.integer  "documented_id"
    t.string   "status",          limit: 10,  default: "active"
    t.string   "country_id",      limit: 20
    t.string   "description",     limit: 255
    t.string   "document_file",   limit: 255
    t.integer  "user_id",                                        null: false
    t.integer  "patron_id",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",              default: 0
    t.integer  "group_id"
    t.integer  "docfiles_count"
    t.boolean  "isdefault",                   default: false
    t.index ["documented_type", "documented_id"], name: "index_arsiv_documents_on_documented_type_and_documented_id", using: :btree
    t.index ["patron_id"], name: "index_arsiv_documents_on_patron_id", using: :btree
  end

  create_table "arsiv_howtos", force: :cascade do |t|
    t.string   "title",      limit: 255,                     null: false
    t.string   "code",       limit: 100,                     null: false
    t.string   "lang",       limit: 2,                       null: false
    t.string   "section",    limit: 30
    t.text     "content"
    t.string   "status",     limit: 10,  default: "pending"
    t.integer  "order_no",               default: 1
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["code", "lang"], name: "index_arsiv_howtos_on_code_and_lang", unique: true, using: :btree
  end

  create_table "arsiv_junks", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "junked_type", limit: 100, null: false
    t.integer  "junked_id",               null: false
    t.integer  "user_id",                 null: false
    t.integer  "patron_id",               null: false
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["junked_type", "junked_id"], name: "index_arsiv_junks_on_junked_type_and_junked_id", using: :btree
    t.index ["user_id", "patron_id"], name: "index_arsiv_junks_on_user_id_and_patron_id", using: :btree
  end

  create_table "arsiv_s3files", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.text     "file_data",               null: false
    t.string   "size",        limit: 20
    t.string   "file_type",   limit: 255
    t.string   "parent_type"
    t.integer  "parent_id"
    t.integer  "email_id"
    t.integer  "group_id"
    t.integer  "user_id",                 null: false
    t.integer  "patron_id",               null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["email_id"], name: "index_arsiv_s3files_on_email_id", using: :btree
    t.index ["group_id"], name: "index_arsiv_s3files_on_group_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_arsiv_s3files_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_arsiv_s3files_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_s3files_on_user_id", using: :btree
  end

  create_table "arsiv_samples", force: :cascade do |t|
    t.string   "title",         limit: 100, null: false
    t.string   "parent_type",   limit: 100, null: false
    t.integer  "user_id",                   null: false
    t.integer  "patron_id",                 null: false
    t.jsonb    "object_fields"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["patron_id"], name: "index_arsiv_samples_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_samples_on_user_id", using: :btree
  end

  create_table "arsiv_service_messages", force: :cascade do |t|
    t.string   "parent_type",             null: false
    t.integer  "parent_id",               null: false
    t.string   "service_name", limit: 50
    t.text     "message"
    t.text     "request"
    t.text     "response"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["parent_type", "parent_id"], name: "index_arsiv_service_messages_on_parent_type_and_parent_id", using: :btree
  end

  create_table "arsiv_survey_answers", force: :cascade do |t|
    t.integer  "survey_section_id"
    t.integer  "user_id"
    t.string   "answer"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "arsiv_survey_options", force: :cascade do |t|
    t.integer  "survey_section_id"
    t.string   "title"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "arsiv_survey_sections", force: :cascade do |t|
    t.string   "section_type"
    t.string   "title"
    t.string   "answer_type"
    t.string   "required"
    t.integer  "survey_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "arsiv_surveys", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "patron_id"
    t.integer  "user_id"
    t.datetime "due_date"
    t.string   "action_scope"
    t.string   "patron_scope", limit: 10
    t.string   "language",     limit: 3
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "arsiv_tempdocs", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "user_id"
    t.integer  "parent_id",               null: false
    t.string   "parent_type",             null: false
    t.text     "code"
    t.integer  "template_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "reference",   limit: 100
    t.index ["parent_type", "parent_id"], name: "index_arsiv_tempdocs_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_arsiv_tempdocs_on_patron_id", using: :btree
    t.index ["template_id"], name: "index_arsiv_tempdocs_on_template_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_tempdocs_on_user_id", using: :btree
  end

  create_table "arsiv_template_docs", force: :cascade do |t|
    t.integer "template_id"
    t.string  "doc_type",    limit: 30
    t.integer "doc_id"
  end

  create_table "arsiv_templates", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "doc_type",           limit: 50
    t.string   "title",              limit: 255
    t.text     "code"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "doc_type_detail",    limit: 100
    t.string   "doc_type_operation", limit: 100
    t.index ["patron_id"], name: "index_arsiv_templates_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_templates_on_user_id", using: :btree
  end

  create_table "arsiv_timeline_statuses", force: :cascade do |t|
    t.string   "name"
    t.string   "engine"
    t.string   "status"
    t.string   "icon_code"
    t.string   "i18n_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "arsiv_timelines", force: :cascade do |t|
    t.string   "parent_type",            limit: 100,                     null: false
    t.integer  "parent_id",                                              null: false
    t.date     "status_date",                                            null: false
    t.string   "status_code",            limit: 100,                     null: false
    t.integer  "place_id"
    t.integer  "city_id"
    t.string   "country_id",             limit: 2
    t.text     "notes"
    t.string   "source",                 limit: 100,                     null: false
    t.integer  "group_id"
    t.integer  "user_id"
    t.integer  "patron_id",                                              null: false
    t.boolean  "customer_inform_type"
    t.string   "customer_inform_status",             default: "pending"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["group_id"], name: "index_arsiv_timelines_on_group_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_arsiv_timelines_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_arsiv_timelines_on_patron_id", using: :btree
  end

  create_table "arsiv_tooltips", force: :cascade do |t|
    t.string   "target_id",  limit: 255
    t.text     "content",                                   null: false
    t.string   "howto_url",  limit: 255
    t.string   "video_url",  limit: 255
    t.string   "status",     limit: 10,  default: "active", null: false
    t.boolean  "highlight",              default: false
    t.integer  "step_order",             default: 1,        null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "arsiv_transfiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "patron_id"
    t.integer  "parent_id"
    t.string   "parent_type",    limit: 30
    t.string   "file_type",      limit: 30,  null: false
    t.date     "file_date",                  null: false
    t.string   "file_no",        limit: 50
    t.text     "carrier"
    t.text     "sender"
    t.text     "consignee"
    t.text     "notify"
    t.text     "agent"
    t.string   "iata_code",      limit: 255
    t.text     "delivery_place"
    t.date     "delivery_date"
    t.text     "loading_place"
    t.date     "loading_date"
    t.text     "attached_docs"
    t.text     "sender_notes"
    t.text     "payment_notes"
    t.string   "payment_type",   limit: 255
    t.text     "carrier_notes"
    t.text     "aggrements"
    t.text     "established"
    t.text     "cod"
    t.text     "marks_no"
    t.text     "pack_number"
    t.text     "pack_type"
    t.text     "commodity"
    t.text     "hts_no"
    t.text     "gross_weight"
    t.text     "volume"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["parent_id"], name: "index_arsiv_transfiles_on_parent_id", using: :btree
    t.index ["parent_type"], name: "index_arsiv_transfiles_on_parent_type", using: :btree
    t.index ["patron_id"], name: "index_arsiv_transfiles_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_arsiv_transfiles_on_user_id", using: :btree
  end

  create_table "assetim_depreciations", force: :cascade do |t|
    t.integer  "patron_id",                                null: false
    t.integer  "ware_id"
    t.date     "dep_date"
    t.integer  "dep_year"
    t.integer  "dep_month"
    t.decimal  "dep_price"
    t.integer  "dep_debit_account_id"
    t.string   "dep_debit_account_code",        limit: 50
    t.integer  "dep_credit_account_id"
    t.string   "dep_credit_account_code",       limit: 50
    t.integer  "dep_debit_profit_center_id"
    t.string   "dep_debit_profit_center_code",  limit: 50
    t.integer  "dep_credit_profit_center_id"
    t.string   "dep_credit_profit_center_code", limit: 50
    t.integer  "ledger_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "assetim_ware_actions", force: :cascade do |t|
    t.integer  "ware_id",                         null: false
    t.date     "action_date",                     null: false
    t.string   "title",               limit: 255, null: false
    t.string   "action_type",         limit: 255
    t.text     "desc"
    t.integer  "user_id",                         null: false
    t.integer  "patron_id",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name",        limit: 255
    t.integer  "person_id"
    t.integer  "total_count"
    t.integer  "transfer_person_id"
    t.integer  "vehicle_id"
    t.integer  "transfer_vehicle_id"
    t.string   "doc_no",              limit: 50
    t.date     "doc_date"
    t.integer  "company_id"
    t.decimal  "price"
    t.string   "price_curr",          limit: 3
    t.string   "string",              limit: 3
    t.index ["patron_id"], name: "index_assetim_ware_actions_on_patron_id", using: :btree
    t.index ["transfer_person_id"], name: "index_assetim_ware_actions_on_transfer_person_id", using: :btree
    t.index ["transfer_vehicle_id"], name: "index_assetim_ware_actions_on_transfer_vehicle_id", using: :btree
    t.index ["vehicle_id"], name: "index_assetim_ware_actions_on_vehicle_id", using: :btree
    t.index ["ware_id"], name: "index_assetim_ware_actions_on_ware_id", using: :btree
  end

  create_table "assetim_ware_groups", force: :cascade do |t|
    t.string   "name",               limit: 100
    t.string   "ware_type",          limit: 20
    t.boolean  "requires_serial_no",             default: false
    t.boolean  "multiple_process",               default: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "patron_id"
  end

  create_table "assetim_wares", force: :cascade do |t|
    t.string   "name",                          limit: 100,                 null: false
    t.string   "serial_no",                     limit: 100
    t.string   "barcode",                       limit: 30
    t.string   "location",                      limit: 255
    t.integer  "branch_id"
    t.string   "status",                        limit: 20
    t.text     "desc"
    t.integer  "patron_id",                                                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "person_id"
    t.string   "group",                         limit: 50
    t.string   "trademark",                     limit: 50
    t.string   "model",                         limit: 255
    t.string   "debit_no",                      limit: 20
    t.integer  "supplier_id"
    t.date     "entry_date"
    t.string   "invoice_no",                    limit: 25
    t.float    "price"
    t.string   "currency",                      limit: 10
    t.string   "warranty",                      limit: 100
    t.text     "details"
    t.string   "owner_company",                 limit: 255
    t.string   "user_company",                  limit: 255
    t.integer  "ware_group_id"
    t.integer  "total_count"
    t.boolean  "trashed",                                   default: false
    t.date     "dep_start_date"
    t.string   "dep_type",                      limit: 20
    t.integer  "dep_period"
    t.boolean  "dep_constant",                              default: false
    t.integer  "dep_duration_year"
    t.integer  "dep_current_year"
    t.integer  "dep_current_month"
    t.decimal  "dep_current_year_price"
    t.decimal  "dep_remained_year_price"
    t.decimal  "dep_rate"
    t.decimal  "dep_price"
    t.decimal  "dep_remained_price"
    t.integer  "dep_debit_account_id"
    t.string   "dep_debit_account_code",        limit: 50
    t.integer  "dep_credit_account_id"
    t.string   "dep_credit_account_code",       limit: 50
    t.integer  "dep_debit_profit_center_id"
    t.string   "dep_debit_profit_center_code",  limit: 50
    t.integer  "dep_credit_profit_center_id"
    t.string   "dep_credit_profit_center_code", limit: 50
    t.string   "dep_status",                    limit: 20
    t.decimal  "dep_selling_price"
    t.decimal  "current_price"
    t.index ["patron_id"], name: "index_assetim_wares_on_patron_id", using: :btree
    t.index ["ware_group_id"], name: "index_assetim_wares_on_ware_group_id", using: :btree
  end

  create_table "auth_proc_users", force: :cascade do |t|
    t.integer "auth_proc_patron_id"
    t.integer "user_id"
    t.string  "status",              default: "active"
    t.index ["auth_proc_patron_id"], name: "index_auth_proc_users_on_auth_proc_patron_id", using: :btree
    t.index ["user_id"], name: "index_auth_proc_users_on_user_id", using: :btree
  end

  create_table "blazer_audits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "query_id"
    t.text     "statement"
    t.string   "data_source"
    t.datetime "created_at"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "query_id"
    t.string   "state"
    t.string   "schedule"
    t.text     "emails"
    t.string   "check_type"
    t.text     "message"
    t.datetime "last_run_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.integer  "dashboard_id"
    t.integer  "query_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.integer  "creator_id"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.text     "description"
    t.text     "statement"
    t.string   "data_source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogger_articles", force: :cascade do |t|
    t.string   "title",               limit: 255,                 null: false
    t.text     "content"
    t.integer  "author_id",                                       null: false
    t.boolean  "confirmed",                       default: false, null: false
    t.date     "publish_date"
    t.string   "website",             limit: 40
    t.integer  "blog_comments_count",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_id"], name: "index_blogger_articles_on_author_id", using: :btree
    t.index ["title"], name: "index_blogger_articles_on_title", using: :btree
  end

  create_table "custom_ftps", force: :cascade do |t|
    t.string   "code"
    t.string   "file_name"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code", "file_name"], name: "index_custom_ftps_on_code_and_file_name", unique: true, using: :btree
  end

  create_table "customs_assigned_letters", force: :cascade do |t|
    t.integer  "letter_id"
    t.decimal  "usable_limit"
    t.string   "status",                  default: "active"
    t.integer  "patron_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "doc_type",     limit: 10
    t.string   "country_id",   limit: 2
  end

  create_table "customs_declarations", force: :cascade do |t|
    t.integer  "manifesto_id"
    t.string   "doc_type",     limit: 30
    t.string   "open_type",    limit: 30
    t.boolean  "is_depot"
    t.string   "depot_code",   limit: 100
    t.string   "doc_no",       limit: 100
    t.string   "line_no",      limit: 100
    t.string   "senet_no"
    t.integer  "good_id"
    t.string   "pack_number"
    t.string   "pack_type"
    t.text     "notes"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.integer  "good_line_no"
    t.index ["manifesto_id"], name: "index_customs_declarations_on_manifesto_id", using: :btree
    t.index ["user_id"], name: "index_customs_declarations_on_user_id", using: :btree
  end

  create_table "customs_documents", force: :cascade do |t|
    t.integer  "good_id",               null: false
    t.string   "pre_post",   limit: 1
    t.string   "doc_type",   limit: 10
    t.string   "doc_no",     limit: 30
    t.integer  "number"
    t.date     "doc_date"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "uuid",       limit: 50
    t.index ["good_id"], name: "index_customs_documents_on_good_id", using: :btree
  end

  create_table "customs_eawb_dims", force: :cascade do |t|
    t.integer  "eawb_rate_id"
    t.integer  "pcs"
    t.integer  "length"
    t.integer  "width"
    t.integer  "height"
    t.integer  "uom"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "customs_eawb_emails", force: :cascade do |t|
    t.string   "name"
    t.string   "email",      limit: 50
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "customs_eawb_handlings", force: :cascade do |t|
    t.integer  "eawb_id"
    t.string   "special_service_information", limit: 100
    t.string   "other_service_information",   limit: 100
    t.string   "sci",                         limit: 2
    t.string   "code",                        limit: 3
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "customs_eawb_othercharges", force: :cascade do |t|
    t.integer  "eawb_id"
    t.string   "description",       limit: 2
    t.decimal  "amount"
    t.string   "charge_identifier", limit: 1
    t.string   "prepaid_collect",   limit: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "customs_eawb_parties", force: :cascade do |t|
    t.integer  "eawb_id"
    t.string   "company_type",   limit: 50, null: false
    t.integer  "win_id"
    t.integer  "account_number"
    t.string   "name",                      null: false
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "address",                   null: false
    t.string   "city_code"
    t.string   "city_name"
    t.string   "postal_code"
    t.string   "state_province"
    t.string   "country_code",              null: false
    t.string   "country_name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "customs_eawb_rates", force: :cascade do |t|
    t.integer  "eawb_id"
    t.integer  "numberofpieces",                        null: false
    t.decimal  "grossweight_value",                     null: false
    t.string   "grossweight_uom",           limit: 1,   null: false
    t.decimal  "volume_value"
    t.string   "volume_uom",                limit: 2
    t.integer  "slac"
    t.string   "rate_class_code",           limit: 1
    t.string   "commodity_item_number",     limit: 7
    t.float    "chargeable_weight"
    t.float    "rateofcharge"
    t.float    "charge_amount",                         null: false
    t.string   "naturalandquantityofgoods", limit: 100
    t.string   "uld_number"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "customs_eawb_routings", force: :cascade do |t|
    t.integer  "eawb_id"
    t.string   "from_airport_code", limit: 3, null: false
    t.string   "to_airport_code",   limit: 3, null: false
    t.string   "carrier_code",      limit: 2, null: false
    t.string   "flight_number",     limit: 5
    t.date     "flight_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "customs_eawbs", force: :cascade do |t|
    t.string   "awb_number",            limit: 12, null: false
    t.string   "awb_status",                       null: false
    t.boolean  "e_awb",                            null: false
    t.boolean  "withpaper"
    t.string   "reference_number",      limit: 14
    t.string   "additionalinformation", limit: 24
    t.string   "currency_code",         limit: 3,  null: false
    t.string   "charge_code",           limit: 2,  null: false
    t.string   "weightorvaluation",     limit: 1,  null: false
    t.string   "other",                 limit: 1,  null: false
    t.string   "valuesforcarriage"
    t.string   "valuesforcustom"
    t.string   "valuesforinsurance"
    t.float    "weight_charge",                    null: false
    t.float    "valuation_charge"
    t.float    "taxes"
    t.date     "date",                             null: false
    t.string   "place",                 limit: 17, null: false
    t.string   "shipper_signature",     limit: 20, null: false
    t.string   "carrier_signature",     limit: 20, null: false
    t.integer  "user_id",                          null: false
    t.integer  "patron_id",                        null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["patron_id"], name: "index_customs_eawbs_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_customs_eawbs_on_user_id", using: :btree
  end

  create_table "customs_goods", force: :cascade do |t|
    t.integer  "manifesto_id",                                         null: false
    t.integer  "loading_id"
    t.string   "commodity",                limit: 255,                 null: false
    t.integer  "gtip_id"
    t.string   "gtip_code",                limit: 20
    t.string   "gtip_language",            limit: 2
    t.float    "brut_wg"
    t.float    "net_wg"
    t.integer  "sender_id"
    t.string   "sender_name",              limit: 100
    t.string   "sender_address",           limit: 255
    t.string   "sender_city",              limit: 60
    t.string   "sender_country_id",        limit: 2
    t.string   "sender_language",          limit: 2
    t.string   "sender_postcode",          limit: 10
    t.string   "sender_taxno",             limit: 20
    t.string   "sender_taxoffice",         limit: 40
    t.integer  "consignee_id"
    t.string   "consignee_name",           limit: 100
    t.string   "consignee_address",        limit: 255
    t.string   "consignee_city",           limit: 60
    t.string   "consignee_country_id",     limit: 2
    t.string   "consignee_language",       limit: 2
    t.string   "consignee_postcode",       limit: 10
    t.string   "consignee_taxno",          limit: 20
    t.string   "consignee_taxoffice",      limit: 40
    t.string   "containers",               limit: 255
    t.decimal  "invoice_amount"
    t.string   "invoice_curr",             limit: 3
    t.string   "exp_customs_no",           limit: 20
    t.string   "exp_customs_type",         limit: 10
    t.boolean  "exp_customs_partial"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "sender_eori_code"
    t.string   "consignee_eori_code"
    t.integer  "line_no"
    t.integer  "user_id"
    t.string   "manifesto_type",           limit: 10
    t.integer  "sender_place_id"
    t.integer  "consignee_place_id"
    t.string   "container_no",             limit: 100
    t.integer  "sender_consignee_no",      limit: 2
    t.decimal  "letter_price"
    t.string   "dep_country_id",           limit: 2
    t.string   "arv_country_id",           limit: 2
    t.string   "sensitive_goods_code"
    t.string   "sensitive_goods_quentity"
    t.string   "additional_info"
    t.text     "notes"
    t.string   "uuid",                     limit: 50
    t.decimal  "duty_rate"
    t.decimal  "excise_rate"
    t.decimal  "vat_rate"
    t.decimal  "duty_amount",                          default: "0.0"
    t.decimal  "excise_amount",                        default: "0.0"
    t.decimal  "vat_amount",                           default: "0.0"
    t.decimal  "curr_rate",                            default: "1.0"
    t.string   "auto_name"
    t.string   "auto_brand"
    t.string   "auto_model"
    t.date     "auto_registration_date"
    t.integer  "auto_seats"
    t.string   "auto_type"
    t.string   "auto_chassis"
    t.string   "auto_engine_number"
    t.integer  "auto_loading_capacity"
    t.string   "auto_color"
    t.integer  "auto_power"
    t.string   "auto_standart"
    t.integer  "working_capacity"
    t.index ["manifesto_id"], name: "index_customs_goods_on_manifesto_id", using: :btree
    t.index ["user_id"], name: "index_customs_goods_on_user_id", using: :btree
  end

  create_table "customs_gtip_rates", force: :cascade do |t|
    t.integer  "gtip_id"
    t.string   "country_id",  limit: 2
    t.decimal  "duty_rate"
    t.decimal  "excise_rate"
    t.decimal  "vat_rate"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "gtip_code",   limit: 20
  end

  create_table "customs_gtips", force: :cascade do |t|
    t.string   "code",       limit: 30,                    null: false
    t.text     "name"
    t.text     "name_en"
    t.text     "name_tr"
    t.text     "name_it"
    t.text     "name_de"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "name_fr"
    t.text     "name_rs"
    t.text     "name_hr"
    t.text     "name_ro"
    t.text     "name_bg"
    t.float    "tax_rate"
    t.boolean  "forbidden",             default: false
    t.string   "status",                default: "active"
    t.decimal  "tr_rate"
    t.decimal  "ro_rate"
    t.decimal  "de_rate"
    t.decimal  "bg_rate"
    t.decimal  "it_rate"
    t.decimal  "fr_rate",               default: "0.0"
    t.text     "name_pl"
    t.decimal  "pl_rate",               default: "0.0"
    t.index ["code"], name: "customs_gtips_unique_code", unique: true, using: :btree
    t.index ["code"], name: "index_customs_gtips_on_code", using: :btree
  end

  create_table "customs_guarantor_users", force: :cascade do |t|
    t.integer  "guarantor_id",           null: false
    t.string   "code"
    t.string   "username"
    t.string   "password"
    t.string   "wsdl_url"
    t.string   "country_id",   limit: 2
    t.string   "pin_code"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["guarantor_id"], name: "index_customs_guarantor_users_on_guarantor_id", using: :btree
  end

  create_table "customs_guarantors", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "contact_id"
    t.string   "status"
    t.integer  "patron_id"
    t.integer  "user_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "bin",              limit: 50
    t.integer  "letters_count",                default: 0
    t.string   "guarantor_type",   limit: 30,  default: "local"
    t.string   "name",             limit: 30
    t.string   "title",            limit: 255
    t.string   "address",          limit: 255
    t.string   "city_name",        limit: 50
    t.string   "country_id",       limit: 2
    t.string   "postcode",         limit: 20
    t.string   "contact_name",     limit: 100
    t.string   "contact_position", limit: 50
    t.string   "contact_email",    limit: 100
    t.string   "contact_tel",      limit: 20
    t.string   "eori_code",        limit: 30
    t.string   "tr_taxno",         limit: 20
    t.string   "de_taxno",         limit: 20
    t.string   "ro_taxno",         limit: 20
    t.index ["company_id"], name: "index_customs_guarantors_on_company_id", using: :btree
    t.index ["contact_id"], name: "index_customs_guarantors_on_contact_id", using: :btree
    t.index ["patron_id"], name: "index_customs_guarantors_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_customs_guarantors_on_user_id", using: :btree
  end

  create_table "customs_hawbs", force: :cascade do |t|
    t.string   "awb_number",                       limit: 12, null: false
    t.string   "hawb_number",                      limit: 12, null: false
    t.string   "hawb_status",                      limit: 1,  null: false
    t.integer  "numberofpieces",                              null: false
    t.float    "grossweight_value",                           null: false
    t.string   "grossweight_uom",                  limit: 1,  null: false
    t.string   "locations_partoforigin_code",      limit: 3,  null: false
    t.string   "locations_partofdestination_code", limit: 3,  null: false
    t.string   "commodity",                                   null: false
    t.integer  "slac"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "customs_letters", force: :cascade do |t|
    t.integer  "guarantor_id"
    t.string   "grn",             limit: 30
    t.string   "code",            limit: 20
    t.decimal  "total",                      default: "0.0"
    t.string   "curr",            limit: 3
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.decimal  "remained_amount"
    t.string   "status",                     default: "active"
    t.string   "scope",           limit: 10
    t.string   "office_code",     limit: 10
  end

  create_table "customs_manifesto_errors", force: :cascade do |t|
    t.integer  "manifesto_id"
    t.string   "code"
    t.string   "description"
    t.string   "language",     limit: 50
    t.string   "status"
    t.string   "form_field",   limit: 30
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["manifesto_id"], name: "index_customs_manifesto_errors_on_manifesto_id", using: :btree
  end

  create_table "customs_manifesto_orders", force: :cascade do |t|
    t.string   "reference"
    t.integer  "patron_id"
    t.integer  "user_id"
    t.integer  "operator_id"
    t.datetime "assigned_at"
    t.integer  "assigned_id"
    t.integer  "position_id"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "customs_manifestos", force: :cascade do |t|
    t.string   "reference",              limit: 30,                      null: false
    t.string   "remote_ref",             limit: 100
    t.integer  "position_id"
    t.integer  "loading_id"
    t.string   "doc_type",               limit: 10,                      null: false
    t.string   "rejim",                  limit: 20
    t.date     "doc_date"
    t.string   "language",               limit: 30,                      null: false
    t.integer  "departure_custom_id",                                    null: false
    t.integer  "arrival_custom_id",                                      null: false
    t.string   "load_coun",              limit: 2,                       null: false
    t.string   "unload_coun",            limit: 2,                       null: false
    t.string   "load_place",             limit: 100
    t.string   "unload_place",           limit: 100
    t.string   "vehicle_type",           limit: 10
    t.string   "trailer_code",           limit: 50
    t.string   "trailer_coun",           limit: 2
    t.string   "vehicle_code",           limit: 50
    t.string   "vehicle_coun",           limit: 2
    t.string   "container",              limit: 50
    t.integer  "total_packages"
    t.float    "total_weight"
    t.integer  "load_count"
    t.string   "transit_customs_ids",    limit: 255
    t.string   "route_country_ids",      limit: 255
    t.string   "contact_name",           limit: 100
    t.string   "guarantee_type",                                         null: false
    t.decimal  "guarantee_price",                    default: "0.0"
    t.integer  "carrier_id",                                             null: false
    t.string   "carrier_name",           limit: 100
    t.string   "carrier_address",        limit: 255
    t.string   "carrier_city",           limit: 60
    t.string   "carrier_country_id",     limit: 2
    t.string   "carrier_language",       limit: 2
    t.string   "carrier_postcode",       limit: 10
    t.string   "carrier_taxno",          limit: 20
    t.string   "carrier_taxoffice",      limit: 40
    t.integer  "guarantor_id",                                           null: false
    t.string   "guarantor_name",         limit: 100
    t.string   "guarantor_address",      limit: 255
    t.string   "guarantor_city",         limit: 60
    t.string   "guarantor_country_id",   limit: 2
    t.string   "guarantor_language",     limit: 2
    t.string   "guarantor_postcode",     limit: 6
    t.string   "guarantor_taxno",        limit: 20
    t.string   "guarantor_taxoffice",    limit: 40
    t.string   "status",                 limit: 30,  default: "draft",   null: false
    t.integer  "goods_count",                        default: 0
    t.integer  "user_id",                                                null: false
    t.integer  "patron_id",                                              null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "guarantor_eori_code"
    t.string   "carrier_eori_code"
    t.integer  "version",                            default: 0
    t.string   "lrn",                    limit: 50
    t.string   "mrn",                    limit: 50
    t.integer  "letter_id"
    t.string   "trans_method",           limit: 10
    t.string   "notes",                  limit: 255
    t.string   "reject_notes",           limit: 255
    t.string   "guid"
    t.text     "error_msg"
    t.date     "transit_date"
    t.string   "payment_type",           limit: 10
    t.boolean  "trashed",                            default: false
    t.integer  "route_id"
    t.boolean  "tanker",                             default: false
    t.decimal  "letter_amount",                      default: "0.0"
    t.boolean  "requires_ens"
    t.integer  "ens_voyage_id"
    t.string   "seal_no",                limit: 100
    t.string   "seal_info",              limit: 100
    t.string   "goods_location",         limit: 100
    t.string   "custom_staff_name"
    t.string   "custom_line"
    t.string   "last_message_index"
    t.string   "dispatch_country_id",    limit: 2
    t.boolean  "security",                           default: false
    t.decimal  "manifesto_price",                    default: "0.0"
    t.string   "manifesto_curr",         limit: 3
    t.integer  "vehicle_id"
    t.integer  "trailer_id"
    t.integer  "parent_manifesto_id"
    t.integer  "approver_id"
    t.datetime "assigned_at"
    t.datetime "approved_at"
    t.string   "access_token",           limit: 100
    t.datetime "invoice_action_date"
    t.string   "invoice_action_type",    limit: 30,  default: "pending"
    t.integer  "sender_id"
    t.integer  "consignee_id"
    t.string   "destination_country_id", limit: 2
    t.string   "position_no",            limit: 100
    t.string   "border_cross_vehicle",   limit: 255
    t.string   "source_type",            limit: 20,  default: "web"
    t.string   "roro_operator_code",     limit: 30
    t.datetime "pending_date"
    t.datetime "send_date"
    t.datetime "mrn_date"
    t.datetime "lrn_date"
    t.datetime "canceled_date"
    t.datetime "vehicle_ready_date"
    t.datetime "vahicle_arrived_date"
    t.datetime "vahicle_free_date"
    t.datetime "manifesto_closed_date"
    t.string   "ens_status",             limit: 20,  default: "draft"
    t.string   "ens_message",            limit: 255
    t.string   "gua_calc_status",                    default: "pending"
    t.string   "ens_voyage_no",          limit: 30
    t.string   "ens_ship_name",          limit: 50
    t.string   "ens_reference",          limit: 30
    t.string   "ens_mrn",                limit: 30
    t.boolean  "summary_entry",                      default: true
    t.boolean  "summary_exit",                       default: true
    t.integer  "tariff_id"
    t.decimal  "guarantee_diff",                     default: "0.0"
    t.decimal  "entry_price",                        default: "0.0"
    t.integer  "target_position_id"
    t.string   "loading_ids"
    t.string   "guarantee_curr",         limit: 3
    t.decimal  "letter_amount_eur"
    t.decimal  "duty_amount_eur"
    t.decimal  "excise_amount_eur"
    t.decimal  "vat_amount_eur"
    t.decimal  "letter_amount_rate"
    t.string   "entry_curr",             limit: 3
    t.decimal  "old_letter_amount"
    t.index ["approver_id"], name: "index_customs_manifestos_on_approver_id", using: :btree
    t.index ["doc_date"], name: "index_customs_manifestos_on_doc_date", using: :btree
    t.index ["doc_type"], name: "index_customs_manifestos_on_doc_type", using: :btree
    t.index ["ens_voyage_id"], name: "index_customs_manifestos_on_ens_voyage_id", using: :btree
    t.index ["guarantor_id"], name: "index_customs_manifestos_on_guarantor_id", using: :btree
    t.index ["loading_id"], name: "index_customs_manifestos_on_loading_id", using: :btree
    t.index ["parent_manifesto_id"], name: "index_customs_manifestos_on_parent_manifesto_id", using: :btree
    t.index ["patron_id"], name: "index_customs_manifestos_on_patron_id", using: :btree
    t.index ["position_id"], name: "index_customs_manifestos_on_position_id", using: :btree
    t.index ["remote_ref"], name: "index_customs_manifestos_on_remote_ref", using: :btree
    t.index ["tariff_id"], name: "index_customs_manifestos_on_tariff_id", using: :btree
    t.index ["trailer_id"], name: "index_customs_manifestos_on_trailer_id", using: :btree
    t.index ["user_id"], name: "index_customs_manifestos_on_user_id", using: :btree
    t.index ["vehicle_id"], name: "index_customs_manifestos_on_vehicle_id", using: :btree
  end

  create_table "customs_packs", force: :cascade do |t|
    t.integer  "good_id",                   null: false
    t.string   "pack_type",      limit: 10
    t.string   "lang_pack_type", limit: 10
    t.string   "pack_species",   limit: 20
    t.integer  "pack_count"
    t.integer  "pack_incount"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "notes"
    t.string   "uuid",           limit: 50
    t.index ["good_id"], name: "index_customs_packs_on_good_id", using: :btree
  end

  create_table "customs_roro_manifestos", force: :cascade do |t|
    t.integer  "manifesto_id"
    t.string   "reference",           limit: 30
    t.date     "declaration_date"
    t.string   "declaration_place",   limit: 100,                     null: false
    t.integer  "transit_custom_id"
    t.string   "status",              limit: 30,  default: "pending"
    t.datetime "status_date_time"
    t.string   "mrn_no",              limit: 30
    t.datetime "mrn_date"
    t.string   "sysmsg",              limit: 255
    t.datetime "cancelled_at"
    t.datetime "remote_cancelled_at"
    t.string   "notes",               limit: 255
    t.integer  "user_id",                                             null: false
    t.integer  "patron_id",                                           null: false
    t.integer  "voyage_id"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["manifesto_id"], name: "index_customs_roro_manifestos_on_manifesto_id", using: :btree
    t.index ["patron_id"], name: "index_customs_roro_manifestos_on_patron_id", using: :btree
    t.index ["reference", "patron_id"], name: "index_customs_roro_manifestos_on_reference_and_patron_id", unique: true, using: :btree
    t.index ["transit_custom_id"], name: "index_customs_roro_manifestos_on_transit_custom_id", using: :btree
    t.index ["user_id"], name: "index_customs_roro_manifestos_on_user_id", using: :btree
    t.index ["voyage_id"], name: "index_customs_roro_manifestos_on_voyage_id", using: :btree
  end

  create_table "customs_tmpgtips", id: false, force: :cascade do |t|
    t.integer  "id"
    t.string   "code",       limit: 30
    t.text     "name"
    t.text     "name_en"
    t.text     "name_tr"
    t.text     "name_it"
    t.text     "name_de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name_fr"
    t.text     "name_rs"
    t.text     "name_hr"
    t.text     "name_ro"
    t.text     "name_bg"
    t.float    "tax_rate"
    t.boolean  "forbidden"
    t.string   "status"
    t.decimal  "tr_rate"
    t.decimal  "ro_rate"
    t.decimal  "de_rate"
    t.decimal  "bg_rate"
    t.decimal  "it_rate"
    t.decimal  "fr_rate"
    t.text     "name_pl"
    t.decimal  "pl_rate"
  end

  create_table "customs_transit_countries", force: :cascade do |t|
    t.integer  "manifesto_id"
    t.string   "country_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["country_id"], name: "index_customs_transit_countries_on_country_id", using: :btree
    t.index ["manifesto_id"], name: "index_customs_transit_countries_on_manifesto_id", using: :btree
  end

  create_table "customs_transit_customs", force: :cascade do |t|
    t.integer  "manifesto_id"
    t.integer  "place_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["manifesto_id"], name: "index_customs_transit_customs_on_manifesto_id", using: :btree
    t.index ["place_id"], name: "index_customs_transit_customs_on_place_id", using: :btree
  end

  create_table "depot_barcodefields", force: :cascade do |t|
    t.integer  "barcode_id",            null: false
    t.string   "code",       limit: 50, null: false
    t.integer  "index",                 null: false
    t.integer  "length",                null: false
    t.string   "format",     limit: 50
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["barcode_id"], name: "index_depot_barcodefields_on_barcode_id", using: :btree
  end

  create_table "depot_barcodes", force: :cascade do |t|
    t.integer  "wareproject_id",                 null: false
    t.string   "sample_code",         limit: 50, null: false
    t.string   "fix_value",           limit: 20
    t.integer  "fix_value_index"
    t.integer  "fix_value_length"
    t.integer  "product_code_index",             null: false
    t.integer  "product_code_length",            null: false
    t.integer  "barcode_length",                 null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "patron_id",                      null: false
    t.index ["patron_id"], name: "index_depot_barcodes_on_patron_id", using: :btree
    t.index ["wareproject_id"], name: "index_depot_barcodes_on_wareproject_id", using: :btree
  end

  create_table "depot_containers", force: :cascade do |t|
    t.string   "name",                  limit: 50
    t.string   "container_type",        limit: 50
    t.string   "seal_no",               limit: 50
    t.string   "truck",                 limit: 20
    t.string   "vessel",                limit: 20
    t.integer  "pallet_count",                      default: 0
    t.integer  "pack_count",                        default: 0
    t.string   "pack_type",             limit: 20
    t.float    "weight",                            default: 0.0
    t.float    "net_weight",                        default: 0.0
    t.integer  "user_id",                                         null: false
    t.integer  "patron_id",                                       null: false
    t.integer  "motion_id",                                       null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "shelf_id"
    t.date     "io_date"
    t.string   "carnet_no",             limit: 50
    t.date     "carnet_date"
    t.string   "supplier_name",         limit: 255
    t.integer  "supplier_id"
    t.string   "lot_no",                limit: 255
    t.string   "name2",                 limit: 50
    t.integer  "logistic_container_id"
    t.string   "uuid",                  limit: 50
    t.index ["logistic_container_id"], name: "index_depot_containers_on_logistic_container_id", using: :btree
    t.index ["motion_id"], name: "index_depot_containers_on_motion_id", using: :btree
    t.index ["patron_id"], name: "index_depot_containers_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_depot_containers_on_user_id", using: :btree
  end

  create_table "depot_locations", force: :cascade do |t|
    t.string   "name",         limit: 100
    t.string   "barcode",      limit: 50
    t.float    "width",                    default: 0.0
    t.float    "height",                   default: 0.0
    t.float    "length",                   default: 0.0
    t.integer  "patron_id",                              null: false
    t.integer  "warehouse_id",                           null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "stock_type",   limit: 30
    t.index ["patron_id"], name: "index_depot_locations_on_patron_id", using: :btree
    t.index ["warehouse_id"], name: "index_depot_locations_on_warehouse_id", using: :btree
  end

  create_table "depot_motion_pallets", force: :cascade do |t|
    t.integer  "motion_id"
    t.integer  "pallet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["motion_id"], name: "index_depot_motion_pallets_on_motion_id", using: :btree
    t.index ["pallet_id"], name: "index_depot_motion_pallets_on_pallet_id", using: :btree
  end

  create_table "depot_motion_products", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "motion_id"
    t.integer  "product_id"
    t.string   "product_name", limit: 255
    t.string   "barcode",      limit: 50
    t.string   "input_output", limit: 20
    t.integer  "count",                    default: 0
    t.float    "weight",                   default: 0.0
    t.float    "net_weight",               default: 0.0
    t.float    "volume",                   default: 0.0
    t.boolean  "trashed",                  default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "depot_motionline_mappings", force: :cascade do |t|
    t.integer  "input_motionline_id"
    t.integer  "output_motionline_id"
    t.integer  "quantity"
    t.decimal  "weight",               default: "0.0"
    t.decimal  "net_weight",           default: "0.0"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "volume",               default: "0.0"
    t.index ["input_motionline_id"], name: "index_depot_motionline_mappings_on_input_motionline_id", using: :btree
    t.index ["output_motionline_id"], name: "index_depot_motionline_mappings_on_output_motionline_id", using: :btree
  end

  create_table "depot_motionline_serials", force: :cascade do |t|
    t.integer  "motionline_id", null: false
    t.string   "serial_no"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "order_id"
    t.integer  "motion_id"
    t.integer  "product_id"
    t.index ["motionline_id"], name: "index_depot_motionline_serials_on_motionline_id", using: :btree
  end

  create_table "depot_motionlines", force: :cascade do |t|
    t.integer  "motion_id"
    t.integer  "product_id"
    t.integer  "gtip_id"
    t.string   "gtip_code"
    t.integer  "pallet_id"
    t.string   "barcode",              limit: 50
    t.string   "serial_no",            limit: 50
    t.decimal  "unit_count",                       default: "0.0"
    t.string   "unit_type",            limit: 50
    t.integer  "pack_count",                       default: 0
    t.float    "weight",                           default: 0.0
    t.float    "volume",                           default: 0.0
    t.string   "notes"
    t.integer  "user_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "orderline_id"
    t.float    "remained_count",                   default: 0.0
    t.integer  "motionline_id"
    t.boolean  "damaged",                          default: false
    t.string   "product_name",         limit: 255
    t.float    "remained_weight",                  default: 0.0
    t.float    "remained_volume",                  default: 0.0
    t.float    "net_weight",                       default: 0.0
    t.float    "remained_net_weight",              default: 0.0
    t.integer  "container_id"
    t.string   "motion_file_no",       limit: 50
    t.integer  "wareproject_id"
    t.integer  "warehouse_id"
    t.integer  "location_id"
    t.integer  "shelf_id"
    t.string   "input_output",         limit: 20
    t.boolean  "blocked",                          default: false
    t.string   "customs_no"
    t.integer  "inner_count",                      default: 0
    t.integer  "line_no"
    t.integer  "remained_inner_count",             default: 0
    t.string   "cap_uid"
    t.boolean  "balanced",                         default: false
    t.text     "transfer_notes"
    t.string   "uuid",                 limit: 50
    t.index ["barcode"], name: "index_depot_motionlines_on_barcode", using: :btree
    t.index ["container_id"], name: "index_depot_motionlines_on_container_id", using: :btree
    t.index ["location_id"], name: "index_depot_motionlines_on_location_id", using: :btree
    t.index ["motion_file_no"], name: "index_depot_motionlines_on_motion_file_no", using: :btree
    t.index ["motion_id"], name: "index_depot_motionlines_on_motion_id", using: :btree
    t.index ["motionline_id"], name: "index_depot_motionlines_on_motionline_id", using: :btree
    t.index ["pallet_id"], name: "index_depot_motionlines_on_pallet_id", using: :btree
    t.index ["product_id"], name: "index_depot_motionlines_on_product_id", using: :btree
    t.index ["product_name"], name: "index_depot_motionlines_on_product_name", using: :btree
    t.index ["shelf_id"], name: "index_depot_motionlines_on_shelf_id", using: :btree
    t.index ["user_id"], name: "index_depot_motionlines_on_user_id", using: :btree
  end

  create_table "depot_motions", force: :cascade do |t|
    t.string   "reference",           limit: 30
    t.integer  "company_id",                                      null: false
    t.integer  "warehouse_id",                                    null: false
    t.integer  "product_id"
    t.date     "entry_date",                                      null: false
    t.string   "input_output",                                    null: false
    t.string   "sender_name",         limit: 500
    t.integer  "sender_id"
    t.string   "consignee_name",      limit: 500
    t.integer  "consignee_id"
    t.string   "notify_name",         limit: 500
    t.integer  "notify_id"
    t.string   "customofficer_name",  limit: 500
    t.integer  "customofficer_id"
    t.string   "file_no",             limit: 50
    t.string   "status",              limit: 50,                  null: false
    t.string   "extref",              limit: 50
    t.string   "customs_doc_no",      limit: 50
    t.date     "customs_doc_date"
    t.string   "depot_ref_no",        limit: 50
    t.date     "depot_ref_date"
    t.string   "transit_doc_no",      limit: 50
    t.date     "transit_doc_date"
    t.integer  "pack_count",                      default: 0
    t.float    "weight",                          default: 0.0
    t.string   "weight_unit",         limit: 20
    t.float    "volume",                          default: 0.0
    t.decimal  "price",                           default: "0.0"
    t.string   "price_curr",          limit: 3
    t.decimal  "deposit_price",                   default: "0.0"
    t.string   "deposit_curr",        limit: 3
    t.text     "notes"
    t.string   "package_type",        limit: 20
    t.text     "commodity"
    t.integer  "parent_motion_id"
    t.integer  "patron_id",                                       null: false
    t.integer  "user_id",                                         null: false
    t.string   "lot_no"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "remained_count",                  default: 0
    t.float    "remained_weight",                 default: 0.0
    t.float    "remained_volume",                 default: 0.0
    t.decimal  "remained_deposit",                default: "0.0"
    t.integer  "tariff_id"
    t.integer  "wareproject_id"
    t.boolean  "return"
    t.integer  "order_id"
    t.integer  "location_id"
    t.string   "incoming_no",         limit: 50
    t.date     "incoming_date"
    t.string   "bl_no",               limit: 50
    t.string   "obd_no",              limit: 50
    t.string   "sales_order_no",      limit: 50
    t.string   "declaration_no",      limit: 50
    t.date     "declaration_date"
    t.string   "receipt_no",          limit: 50
    t.date     "receipt_date"
    t.integer  "agent_id"
    t.float    "net_weight",                      default: 0.0
    t.float    "remained_net_weight",             default: 0.0
    t.string   "doc_type"
    t.string   "regime_code"
    t.integer  "custom_id"
    t.integer  "loading_id"
    t.decimal  "estimated_debit",                 default: "0.0"
    t.decimal  "estimated_credit",                default: "0.0"
    t.decimal  "invoiced_debit",                  default: "0.0"
    t.decimal  "invoiced_credit",                 default: "0.0"
    t.string   "project_no"
    t.string   "assignor",            limit: 100
    t.integer  "representative_id"
    t.string   "uuid",                limit: 50
    t.integer  "pallet_count"
    t.index ["company_id"], name: "index_depot_motions_on_company_id", using: :btree
    t.index ["custom_id"], name: "index_depot_motions_on_custom_id", using: :btree
    t.index ["entry_date"], name: "index_depot_motions_on_entry_date", using: :btree
    t.index ["file_no"], name: "index_depot_motions_on_file_no", using: :btree
    t.index ["input_output"], name: "index_depot_motions_on_input_output", using: :btree
    t.index ["loading_id"], name: "index_depot_motions_on_loading_id", using: :btree
    t.index ["order_id"], name: "index_depot_motions_on_order_id", using: :btree
    t.index ["parent_motion_id"], name: "index_depot_motions_on_parent_motion_id", using: :btree
    t.index ["patron_id"], name: "index_depot_motions_on_patron_id", using: :btree
    t.index ["product_id"], name: "index_depot_motions_on_product_id", using: :btree
    t.index ["representative_id"], name: "index_depot_motions_on_representative_id", using: :btree
    t.index ["tariff_id"], name: "index_depot_motions_on_tariff_id", using: :btree
    t.index ["user_id"], name: "index_depot_motions_on_user_id", using: :btree
    t.index ["warehouse_id"], name: "index_depot_motions_on_warehouse_id", using: :btree
    t.index ["wareproject_id"], name: "index_depot_motions_on_wareproject_id", using: :btree
  end

  create_table "depot_orderlines", force: :cascade do |t|
    t.integer  "order_id",                                     null: false
    t.integer  "product_id"
    t.string   "barcode",             limit: 50
    t.string   "serial_no",           limit: 50
    t.string   "pack_type",           limit: 50
    t.integer  "pack_count",                     default: 0
    t.integer  "remained_count",                 default: 0
    t.float    "weight",                         default: 0.0
    t.float    "remained_weight",                default: 0.0
    t.text     "notes"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.float    "volume",                         default: 0.0
    t.float    "remained_volume",                default: 0.0
    t.float    "price",                          default: 0.0
    t.string   "price_curr",          limit: 3
    t.float    "price_curr_rate",                default: 1.0
    t.string   "uuid",                limit: 50
    t.float    "net_weight",                     default: 0.0
    t.float    "remained_net_weight",            default: 0.0
    t.index ["order_id"], name: "index_depot_orderlines_on_order_id", using: :btree
    t.index ["product_id"], name: "index_depot_orderlines_on_product_id", using: :btree
  end

  create_table "depot_orders", force: :cascade do |t|
    t.string   "reference",      limit: 50,                  null: false
    t.date     "entry_date",                                 null: false
    t.string   "input_output",   limit: 10,                  null: false
    t.string   "sender_name",    limit: 100
    t.integer  "sender_id"
    t.string   "consignee_name", limit: 100
    t.integer  "consignee_id"
    t.string   "notify_name",    limit: 100
    t.integer  "notify_id"
    t.string   "file_no",        limit: 50
    t.string   "status",         limit: 50,                  null: false
    t.string   "extref",         limit: 50
    t.integer  "pack_count",                 default: 0
    t.integer  "remained_count",             default: 0
    t.text     "notes"
    t.integer  "company_id",                                 null: false
    t.integer  "warehouse_id",                               null: false
    t.integer  "wareproject_id",                             null: false
    t.integer  "patron_id",                                  null: false
    t.integer  "user_id",                                    null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "debit_credit"
    t.string   "order_no",       limit: 20
    t.string   "tax_office",     limit: 100
    t.string   "tax_no",         limit: 50
    t.text     "order_address"
    t.string   "district",       limit: 100
    t.string   "city",           limit: 100
    t.integer  "location_id"
    t.boolean  "trashed",                    default: false
    t.boolean  "damaged",                    default: false
    t.string   "project_no"
    t.string   "uuid",           limit: 50
    t.index ["company_id"], name: "index_depot_orders_on_company_id", using: :btree
    t.index ["consignee_id"], name: "index_depot_orders_on_consignee_id", using: :btree
    t.index ["entry_date"], name: "index_depot_orders_on_entry_date", using: :btree
    t.index ["file_no"], name: "index_depot_orders_on_file_no", using: :btree
    t.index ["input_output"], name: "index_depot_orders_on_input_output", using: :btree
    t.index ["location_id"], name: "index_depot_orders_on_location_id", using: :btree
    t.index ["notify_id"], name: "index_depot_orders_on_notify_id", using: :btree
    t.index ["patron_id"], name: "index_depot_orders_on_patron_id", using: :btree
    t.index ["reference"], name: "index_depot_orders_on_reference", using: :btree
    t.index ["sender_id"], name: "index_depot_orders_on_sender_id", using: :btree
    t.index ["user_id"], name: "index_depot_orders_on_user_id", using: :btree
    t.index ["warehouse_id"], name: "index_depot_orders_on_warehouse_id", using: :btree
    t.index ["wareproject_id"], name: "index_depot_orders_on_wareproject_id", using: :btree
  end

  create_table "depot_pallets", force: :cascade do |t|
    t.integer  "location_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "wareproject_id"
    t.integer  "shelf_id"
    t.integer  "warehouse_id"
    t.string   "barcode",               limit: 50
    t.integer  "reference_pallet_id"
    t.integer  "pack_count"
    t.integer  "motion_id"
    t.string   "motion_file_no",        limit: 50
    t.integer  "container_id"
    t.string   "lot_no",                limit: 50
    t.boolean  "damaged",                          default: false
    t.date     "io_date"
    t.integer  "patron_id"
    t.integer  "reference_location_id"
    t.integer  "reference_shelf_id"
    t.string   "serial_no"
    t.integer  "gtip_id"
    t.string   "pack_type",             limit: 20
    t.string   "gtip_code",             limit: 20
    t.index ["barcode"], name: "index_depot_pallets_on_barcode", using: :btree
    t.index ["gtip_id"], name: "index_depot_pallets_on_gtip_id", using: :btree
    t.index ["location_id"], name: "index_depot_pallets_on_location_id", using: :btree
    t.index ["motion_file_no"], name: "index_depot_pallets_on_motion_file_no", using: :btree
    t.index ["patron_id"], name: "index_depot_pallets_on_patron_id", using: :btree
    t.index ["reference_location_id"], name: "index_depot_pallets_on_reference_location_id", using: :btree
    t.index ["reference_shelf_id"], name: "index_depot_pallets_on_reference_shelf_id", using: :btree
    t.index ["wareproject_id"], name: "index_depot_pallets_on_wareproject_id", using: :btree
  end

  create_table "depot_product_groups", force: :cascade do |t|
    t.integer  "wareproject_id",                                null: false
    t.string   "name",           limit: 100
    t.text     "notes"
    t.string   "status",         limit: 20,  default: "active"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["wareproject_id"], name: "index_depot_product_groups_on_wareproject_id", using: :btree
  end

  create_table "depot_product_parts", force: :cascade do |t|
    t.integer  "parent_product_id"
    t.integer  "sub_product_id"
    t.integer  "total_count",       default: 1
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["parent_product_id"], name: "index_depot_product_parts_on_parent_product_id", using: :btree
    t.index ["sub_product_id"], name: "index_depot_product_parts_on_sub_product_id", using: :btree
  end

  create_table "depot_product_stocks", force: :cascade do |t|
    t.string   "sku",            limit: 255
    t.float    "count",                      default: 0.0
    t.integer  "patron_id",                                  null: false
    t.integer  "warehouse_id",                               null: false
    t.integer  "wareproject_id",                             null: false
    t.integer  "company_id",                                 null: false
    t.integer  "product_id",                                 null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.float    "weight",                     default: 0.0
    t.float    "net_weight",                 default: 0.0
    t.float    "volume",                     default: 0.0
    t.boolean  "damaged",                    default: false
    t.boolean  "blocked",                    default: false
    t.index ["company_id"], name: "index_depot_product_stocks_on_company_id", using: :btree
    t.index ["patron_id"], name: "index_depot_product_stocks_on_patron_id", using: :btree
    t.index ["product_id"], name: "index_depot_product_stocks_on_product_id", using: :btree
    t.index ["warehouse_id"], name: "index_depot_product_stocks_on_warehouse_id", using: :btree
    t.index ["wareproject_id"], name: "index_depot_product_stocks_on_wareproject_id", using: :btree
  end

  create_table "depot_products", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "warehouse_id"
    t.string   "code",               limit: 100
    t.string   "product_name",       limit: 255,                 null: false
    t.string   "country_id",         limit: 2
    t.string   "gtip_code",          limit: 20
    t.decimal  "price",                          default: "0.0"
    t.string   "price_curr",         limit: 3
    t.decimal  "deposit_price",                  default: "0.0"
    t.string   "deposit_curr",       limit: 3
    t.float    "total_count",                    default: 0.0
    t.float    "total_weight",                   default: 0.0
    t.string   "weight_unit",        limit: 20
    t.float    "total_volume",                   default: 0.0
    t.text     "notes"
    t.integer  "patron_id",                                      null: false
    t.integer  "user_id",                                        null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "wareproject_id",                                 null: false
    t.integer  "product_group_id"
    t.string   "barcode",            limit: 100
    t.string   "product_name_eng",   limit: 255
    t.string   "imco",               limit: 50
    t.string   "max_temperature",    limit: 50
    t.string   "storage_area",       limit: 50
    t.float    "min_temperature",                default: 0.0
    t.integer  "min_count",                      default: 0
    t.float    "pallet_length",                  default: 0.0
    t.float    "pallet_width",                   default: 0.0
    t.float    "pallet_height",                  default: 0.0
    t.float    "length",                         default: 0.0
    t.float    "width",                          default: 0.0
    t.float    "height",                         default: 0.0
    t.float    "chargeable_weight",              default: 0.0
    t.integer  "pallet_inner_count"
    t.string   "sku_model",          limit: 50
    t.string   "io_type",            limit: 20
    t.string   "warehouse_type",     limit: 50
    t.integer  "max_pallet_floor"
    t.float    "net_weight",                     default: 0.0
    t.string   "pack_type",          limit: 50
    t.float    "total_net_weight",               default: 0.0
    t.float    "volume",                         default: 0.0,   null: false
    t.boolean  "blocked",                        default: false
    t.string   "fifo_lifo",          limit: 20
    t.index ["company_id"], name: "index_depot_products_on_company_id", using: :btree
    t.index ["patron_id"], name: "index_depot_products_on_patron_id", using: :btree
    t.index ["product_group_id"], name: "index_depot_products_on_product_group_id", using: :btree
    t.index ["user_id"], name: "index_depot_products_on_user_id", using: :btree
    t.index ["wareproject_id"], name: "index_depot_products_on_wareproject_id", using: :btree
  end

  create_table "depot_shelves", force: :cascade do |t|
    t.integer  "warehouse_id",                         null: false
    t.string   "title",        limit: 50
    t.string   "name",         limit: 100
    t.integer  "cell",                     default: 0
    t.integer  "floor",                    default: 0
    t.string   "barcode",      limit: 50
    t.integer  "patron_id",                            null: false
    t.integer  "user_id",                              null: false
    t.integer  "pallet_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "shelf_depth"
    t.integer  "pallet_count"
    t.float    "max_weight"
    t.integer  "corridor"
    t.index ["pallet_id"], name: "index_depot_shelves_on_pallet_id", using: :btree
    t.index ["patron_id"], name: "index_depot_shelves_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_depot_shelves_on_user_id", using: :btree
    t.index ["warehouse_id"], name: "index_depot_shelves_on_warehouse_id", using: :btree
  end

  create_table "depot_submotionlines", force: :cascade do |t|
    t.string   "parent_uid"
    t.integer  "product_id"
    t.string   "product_name"
    t.integer  "line_no"
    t.integer  "gtip_id"
    t.integer  "count",                          default: 0
    t.float    "weight",                         default: 0.0
    t.float    "net_weight",                     default: 0.0
    t.float    "volume",                         default: 0.0
    t.integer  "remained_count",                 default: 0
    t.float    "remained_weight",                default: 0.0
    t.float    "remained_net_weight",            default: 0.0
    t.float    "remained_volume",                default: 0.0
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "product_barcode",     limit: 50
    t.integer  "pallet_id"
    t.integer  "user_id"
    t.integer  "motion_id"
    t.string   "gtip_code",           limit: 20
  end

  create_table "depot_tarifflines", force: :cascade do |t|
    t.integer  "tariff_id",                             null: false
    t.string   "cunit1"
    t.string   "cunit2"
    t.decimal  "rate"
    t.integer  "start_day"
    t.integer  "finish_day"
    t.integer  "finitem_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.decimal  "min_price",             default: "0.0"
    t.string   "curr",       limit: 3
    t.string   "period",     limit: 20
    t.index ["finitem_id"], name: "index_depot_tarifflines_on_finitem_id", using: :btree
    t.index ["tariff_id"], name: "index_depot_tarifflines_on_tariff_id", using: :btree
  end

  create_table "depot_tariffs", force: :cascade do |t|
    t.string   "title",        limit: 255, null: false
    t.date     "due_date"
    t.decimal  "min_price"
    t.string   "curr",         limit: 3
    t.string   "status",       limit: 20
    t.integer  "warehouse_id"
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "patron_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["company_id"], name: "index_depot_tariffs_on_company_id", using: :btree
    t.index ["patron_id"], name: "index_depot_tariffs_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_depot_tariffs_on_user_id", using: :btree
    t.index ["warehouse_id"], name: "index_depot_tariffs_on_warehouse_id", using: :btree
  end

  create_table "depot_warehouse_performances", force: :cascade do |t|
    t.integer "warehouse_id",                                   null: false
    t.date    "date"
    t.integer "input_count",                    default: 0
    t.float   "input_weight",                   default: 0.0
    t.float   "input_volume",                   default: 0.0
    t.decimal "input_deposit_price",            default: "0.0"
    t.string  "input_deposit_curr",   limit: 3
    t.integer "output_count",                   default: 0
    t.float   "output_weight",                  default: 0.0
    t.float   "output_volume",                  default: 0.0
    t.decimal "output_deposit_price",           default: "0.0"
    t.string  "output_deposit_curr",  limit: 3
    t.integer "patron_id",                                      null: false
    t.integer "wareproject_id"
    t.index ["patron_id"], name: "index_depot_warehouse_performances_on_patron_id", using: :btree
    t.index ["warehouse_id"], name: "index_depot_warehouse_performances_on_warehouse_id", using: :btree
    t.index ["wareproject_id"], name: "index_depot_warehouse_performances_on_wareproject_id", using: :btree
  end

  create_table "depot_warehouses", force: :cascade do |t|
    t.string   "name",             limit: 255,                 null: false
    t.string   "warehouse_class",  limit: 50,                  null: false
    t.string   "warehouse_type",   limit: 50
    t.integer  "branch_id",                                    null: false
    t.string   "address",          limit: 255
    t.integer  "place_id"
    t.integer  "user_id",                                      null: false
    t.integer  "patron_id",                                    null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "input_type",       limit: 20
    t.decimal  "deposit_price"
    t.string   "customs_code",     limit: 50
    t.string   "warehouse_code",   limit: 50
    t.decimal  "weight",                       default: "0.0"
    t.decimal  "volume",                       default: "0.0"
    t.decimal  "area",                         default: "0.0"
    t.string   "customhouse_code"
    t.index ["branch_id"], name: "index_depot_warehouses_on_branch_id", using: :btree
    t.index ["patron_id"], name: "index_depot_warehouses_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_depot_warehouses_on_user_id", using: :btree
  end

  create_table "depot_wareprojects", force: :cascade do |t|
    t.string   "name",            limit: 255,                    null: false
    t.text     "notes"
    t.string   "status",          limit: 20,  default: "active"
    t.integer  "warehouse_id",                                   null: false
    t.integer  "patron_id",                                      null: false
    t.integer  "user_id",                                        null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "company_id",                                     null: false
    t.string   "input_type",      limit: 20
    t.string   "order_type",      limit: 20
    t.string   "control_type",    limit: 50
    t.string   "collection_type", limit: 50
    t.index ["company_id"], name: "index_depot_wareprojects_on_company_id", using: :btree
    t.index ["patron_id"], name: "index_depot_wareprojects_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_depot_wareprojects_on_user_id", using: :btree
    t.index ["warehouse_id"], name: "index_depot_wareprojects_on_warehouse_id", using: :btree
  end

  create_table "depot_wareprojects_companies", force: :cascade do |t|
    t.integer "wareproject_id", null: false
    t.integer "company_id",     null: false
    t.index ["company_id"], name: "index_depot_wareprojects_companies_on_company_id", using: :btree
    t.index ["wareproject_id"], name: "index_depot_wareprojects_companies_on_wareproject_id", using: :btree
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "surname",    limit: 255, null: false
    t.date     "birth_date"
    t.decimal  "tc_no"
    t.decimal  "phone"
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "financor_account_mappings", force: :cascade do |t|
    t.string   "ledger_account_code"
    t.string   "profit_center_code"
    t.integer  "user_id",              null: false
    t.integer  "patron_id",            null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "ledger_account_code2"
    t.index ["ledger_account_code"], name: "index_financor_account_mappings_on_ledger_account_code", using: :btree
    t.index ["patron_id"], name: "index_financor_account_mappings_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_account_mappings_on_user_id", using: :btree
  end

  create_table "financor_accounts", force: :cascade do |t|
    t.integer  "patron_id",                                          null: false
    t.integer  "user_id",                                            null: false
    t.string   "name",                limit: 255,                    null: false
    t.integer  "parent_id",                                          null: false
    t.string   "parent_type",                                        null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "code",                limit: 50
    t.string   "curr",                limit: 3
    t.string   "parent_type2",        limit: 50
    t.string   "parent_type1",        limit: 50
    t.integer  "ledger_account_id"
    t.integer  "profit_center_id"
    t.string   "work_type",           limit: 20
    t.string   "profit_center_code",  limit: 100
    t.string   "ledger_account_code", limit: 100
    t.string   "status",                          default: "active"
    t.integer  "fiscal_year",         limit: 2
    t.index ["ledger_account_id"], name: "index_financor_accounts_on_ledger_account_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_financor_accounts_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_accounts_on_patron_id", using: :btree
    t.index ["profit_center_id"], name: "index_financor_accounts_on_profit_center_id", using: :btree
    t.index ["user_id"], name: "index_financor_accounts_on_user_id", using: :btree
  end

  create_table "financor_accountsums", force: :cascade do |t|
    t.integer "patron_id",                                null: false
    t.integer "account_id",                               null: false
    t.string  "account_code", limit: 255
    t.string  "curr",                                     null: false
    t.decimal "debit",                    default: "0.0"
    t.decimal "credit",                   default: "0.0"
    t.decimal "debit_local",              default: "0.0"
    t.decimal "credit_local",             default: "0.0"
    t.index ["patron_id"], name: "index_financor_accountsums_on_patron_id", using: :btree
  end

  create_table "financor_agreement_periods", force: :cascade do |t|
    t.string   "title"
    t.date     "start_date"
    t.date     "finish_date"
    t.string   "doc_type"
    t.string   "status",                          default: "pending"
    t.integer  "patron_id",                                           null: false
    t.integer  "user_id",                                             null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "address"
    t.string   "email"
    t.text     "notes"
    t.integer  "branch_id"
    t.string   "ledger_account_code1", limit: 30
    t.string   "ledger_account_code2", limit: 30
    t.decimal  "invoice_limit",                   default: "0.0"
    t.integer  "financial_user_id"
    t.index ["branch_id"], name: "index_financor_agreement_periods_on_branch_id", using: :btree
    t.index ["financial_user_id"], name: "index_financor_agreement_periods_on_financial_user_id", using: :btree
    t.index ["patron_id"], name: "index_financor_agreement_periods_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_agreement_periods_on_user_id", using: :btree
  end

  create_table "financor_agreements", force: :cascade do |t|
    t.date     "document_date",                                       null: false
    t.integer  "parent_id",                                           null: false
    t.string   "parent_type",                                         null: false
    t.decimal  "debit_sum",                       default: "0.0"
    t.decimal  "credit_sum",                      default: "0.0"
    t.text     "notes"
    t.integer  "patron_id",                                           null: false
    t.integer  "user_id",                                             null: false
    t.string   "status",              limit: 20,  default: "pending", null: false
    t.string   "agreement_curr",      limit: 3,                       null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "agreement_period_id"
    t.string   "taxno",               limit: 30
    t.integer  "doc_count"
    t.text     "emails"
    t.string   "approver_name",       limit: 50
    t.date     "approved_at"
    t.integer  "comments_count"
    t.integer  "branch_id"
    t.string   "title"
    t.integer  "financial_person_id"
    t.string   "access_token",        limit: 255
    t.string   "approver_ip",         limit: 50
    t.boolean  "trashed",                         default: false
    t.index ["parent_type", "parent_id"], name: "index_financor_agreements_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_agreements_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_agreements_on_user_id", using: :btree
  end

  create_table "financor_balanceheads", force: :cascade do |t|
    t.integer  "balance_id"
    t.integer  "balancehead_id"
    t.string   "code"
    t.string   "title"
    t.integer  "level"
    t.boolean  "viewable",           default: true
    t.string   "balance_type"
    t.integer  "patron_id"
    t.integer  "user_id"
    t.boolean  "trashed",            default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "ref_balancehead_id"
    t.decimal  "amount"
    t.index ["balance_id"], name: "index_financor_balanceheads_on_balance_id", using: :btree
    t.index ["balancehead_id"], name: "index_financor_balanceheads_on_balancehead_id", using: :btree
    t.index ["patron_id"], name: "index_financor_balanceheads_on_patron_id", using: :btree
    t.index ["trashed"], name: "index_financor_balanceheads_on_trashed", using: :btree
    t.index ["user_id"], name: "index_financor_balanceheads_on_user_id", using: :btree
  end

  create_table "financor_balancelines", force: :cascade do |t|
    t.integer  "balancehead_id"
    t.string   "start_account",        limit: 50
    t.string   "finish_account",       limit: 50
    t.string   "status",               limit: 50
    t.string   "formul",               limit: 50
    t.string   "balanceline_type",     limit: 50
    t.integer  "patron_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.float    "multiplier"
    t.string   "start_profit_center",  limit: 50
    t.string   "finish_profit_center", limit: 50
    t.decimal  "amount"
    t.integer  "fiscal_month"
    t.string   "ext_where"
    t.string   "curr",                 limit: 3
    t.decimal  "rate"
    t.date     "due_date"
    t.index ["balancehead_id"], name: "index_financor_balancelines_on_balancehead_id", using: :btree
    t.index ["patron_id"], name: "index_financor_balancelines_on_patron_id", using: :btree
  end

  create_table "financor_balances", force: :cascade do |t|
    t.string   "title"
    t.integer  "patron_id"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "order_number"
    t.string   "report_type"
    t.integer  "ref_balance_id"
    t.integer  "fiscal_year"
    t.string   "other_patron_ids", limit: 500
    t.string   "order_str",        limit: 2000
    t.index ["patron_id"], name: "index_financor_balances_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_balances_on_user_id", using: :btree
  end

  create_table "financor_bank_letters", force: :cascade do |t|
    t.string   "name",              limit: 30,                     null: false
    t.date     "letter_date",                                      null: false
    t.decimal  "amount",                        default: "0.0",    null: false
    t.string   "curr",              limit: 3,                      null: false
    t.string   "debit_credit",      limit: 10,                     null: false
    t.integer  "bank_id",                                          null: false
    t.integer  "finpoint_id"
    t.integer  "company_id"
    t.integer  "ledger_account_id"
    t.string   "status",                        default: "active", null: false
    t.string   "notes"
    t.integer  "user_id",                                          null: false
    t.integer  "patron_id",                                        null: false
    t.boolean  "trashed",                       default: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "issue_note",        limit: 255
    t.date     "due_date"
    t.decimal  "comm_rate",                     default: "0.0"
    t.index ["bank_id"], name: "index_financor_bank_letters_on_bank_id", using: :btree
    t.index ["company_id"], name: "index_financor_bank_letters_on_company_id", using: :btree
    t.index ["finpoint_id"], name: "index_financor_bank_letters_on_finpoint_id", using: :btree
    t.index ["ledger_account_id"], name: "index_financor_bank_letters_on_ledger_account_id", using: :btree
    t.index ["patron_id"], name: "index_financor_bank_letters_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_bank_letters_on_user_id", using: :btree
  end

  create_table "financor_bank_payments", force: :cascade do |t|
    t.integer  "bank_account_id"
    t.string   "account_no"
    t.date     "payment_date"
    t.string   "status",          default: "pending"
    t.integer  "user_id"
    t.integer  "patron_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["bank_account_id"], name: "index_financor_bank_payments_on_bank_account_id", using: :btree
    t.index ["patron_id"], name: "index_financor_bank_payments_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_bank_payments_on_user_id", using: :btree
  end

  create_table "financor_bank_settings", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "service_type"
    t.string   "user_name"
    t.string   "password"
    t.string   "debit_credit"
    t.string   "iban"
    t.integer  "bank_id"
    t.string   "bank_branch"
    t.integer  "patron_id",    null: false
    t.integer  "user_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["patron_id"], name: "index_financor_bank_settings_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_bank_settings_on_user_id", using: :btree
  end

  create_table "financor_bank_transfers", force: :cascade do |t|
    t.string  "iban",            limit: 50
    t.string  "company_name",    limit: 50
    t.string  "tax_office"
    t.string  "sender_reciever"
    t.decimal "amount"
    t.date    "created_date"
  end

  create_table "financor_bankdisklines", force: :cascade do |t|
    t.integer  "bankdisk_id",                     null: false
    t.string   "line_type"
    t.string   "column_no",       default: "0"
    t.text     "query"
    t.integer  "length",          default: 0
    t.integer  "blank"
    t.string   "align"
    t.string   "blank_character"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "line_no",         default: 0
    t.boolean  "static",          default: false
    t.index ["bankdisk_id"], name: "index_financor_bankdisklines_on_bankdisk_id", using: :btree
  end

  create_table "financor_bankdisks", force: :cascade do |t|
    t.string   "code",               limit: 10
    t.string   "name"
    t.string   "bank_id"
    t.string   "disk_type"
    t.text     "notes"
    t.text     "status",                        default: "active"
    t.integer  "patron_id",                                        null: false
    t.integer  "user_id",                                          null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "new_line_character",            default: "\n"
    t.index ["patron_id"], name: "index_financor_bankdisks_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_bankdisks_on_user_id", using: :btree
  end

  create_table "financor_banks", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.string   "tel"
    t.string   "fax"
    t.string   "website"
    t.string   "telex"
    t.string   "eft"
    t.string   "swift"
    t.string   "country_id", limit: 2
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["country_id"], name: "index_financor_banks_on_country_id", using: :btree
  end

  create_table "financor_budgetlines", force: :cascade do |t|
    t.string   "name",          limit: 255,                    null: false
    t.string   "line_type",     limit: 20,                     null: false
    t.integer  "company_id"
    t.decimal  "amount",                    default: "0.0"
    t.string   "curr",          limit: 3,                      null: false
    t.string   "line_group",    limit: 30
    t.string   "budgeted_type", limit: 100
    t.integer  "budgeted_id"
    t.string   "status",        limit: 10,  default: "active"
    t.text     "notes"
    t.integer  "user_id",                                      null: false
    t.integer  "patron_id",                                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financor_chartofaccounts", force: :cascade do |t|
    t.integer  "patron_id",                          null: false
    t.string   "code",       limit: 50,              null: false
    t.string   "title",      limit: 255,             null: false
    t.integer  "digit",                              null: false
    t.integer  "last_seq",               default: 0, null: false
    t.string   "type1",      limit: 50
    t.string   "type2",      limit: 50
    t.string   "status",     limit: 50
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id",                            null: false
    t.index ["patron_id"], name: "index_financor_chartofaccounts_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_chartofaccounts_on_user_id", using: :btree
  end

  create_table "financor_cheque_actions", force: :cascade do |t|
    t.string   "doc_type"
    t.string   "name",          limit: 100
    t.string   "actual_status", limit: 30
    t.string   "new_status",    limit: 30
    t.integer  "patron_id",                 null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["patron_id"], name: "index_financor_cheque_actions_on_patron_id", using: :btree
  end

  create_table "financor_cheque_books", force: :cascade do |t|
    t.string   "doc_type",                                null: false
    t.integer  "start_no",                    default: 0
    t.integer  "page_count",                  default: 0
    t.integer  "unused_page_count",           default: 0
    t.string   "curr",              limit: 3
    t.integer  "finpoint_id"
    t.integer  "branch_id"
    t.date     "doc_date"
    t.text     "notes"
    t.integer  "user_id",                                 null: false
    t.integer  "patron_id",                               null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "book_name"
    t.index ["branch_id"], name: "index_financor_cheque_books_on_branch_id", using: :btree
    t.index ["doc_type"], name: "index_financor_cheque_books_on_doc_type", using: :btree
    t.index ["finpoint_id"], name: "index_financor_cheque_books_on_finpoint_id", using: :btree
    t.index ["patron_id"], name: "index_financor_cheque_books_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_cheque_books_on_user_id", using: :btree
  end

  create_table "financor_cheque_portfolios", force: :cascade do |t|
    t.string   "doc_type",               null: false
    t.string   "name",       limit: 100, null: false
    t.integer  "branch_id"
    t.integer  "patron_id",              null: false
    t.integer  "user_id",                null: false
    t.string   "curr",       limit: 3
    t.text     "notes"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["branch_id"], name: "index_financor_cheque_portfolios_on_branch_id", using: :btree
    t.index ["doc_type"], name: "index_financor_cheque_portfolios_on_doc_type", using: :btree
    t.index ["patron_id"], name: "index_financor_cheque_portfolios_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_cheque_portfolios_on_user_id", using: :btree
  end

  create_table "financor_cheques", force: :cascade do |t|
    t.string   "doc_type",                                         null: false
    t.string   "parent_type",                                      null: false
    t.integer  "parent_id",                                        null: false
    t.integer  "company_id"
    t.string   "doc_no",           limit: 20,                      null: false
    t.date     "due_date"
    t.float    "amount",                       default: 0.0
    t.string   "curr",             limit: 3
    t.string   "status",           limit: 20,  default: "pending"
    t.integer  "branch_id"
    t.integer  "saler_id"
    t.string   "doc_account_no"
    t.string   "doc_title"
    t.string   "doc_taxno"
    t.string   "doc_bank"
    t.string   "doc_branch"
    t.string   "doc_address"
    t.integer  "user_id",                                          null: false
    t.integer  "patron_id",                                        null: false
    t.string   "notes",            limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.date     "doc_date"
    t.string   "account_type"
    t.integer  "account_id"
    t.integer  "profit_center_id"
    t.index ["account_type", "account_id"], name: "index_financor_cheques_on_account_type_and_account_id", using: :btree
    t.index ["branch_id"], name: "index_financor_cheques_on_branch_id", using: :btree
    t.index ["company_id"], name: "index_financor_cheques_on_company_id", using: :btree
    t.index ["doc_type"], name: "index_financor_cheques_on_doc_type", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_financor_cheques_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_cheques_on_patron_id", using: :btree
    t.index ["profit_center_id"], name: "index_financor_cheques_on_profit_center_id", using: :btree
    t.index ["saler_id"], name: "index_financor_cheques_on_saler_id", using: :btree
    t.index ["user_id"], name: "index_financor_cheques_on_user_id", using: :btree
  end

  create_table "financor_counter_users", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "user_id"
    t.integer  "invoice_counter_id"
    t.string   "invoice_type",       limit: 20
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["invoice_counter_id"], name: "index_financor_counter_users_on_invoice_counter_id", using: :btree
    t.index ["patron_id"], name: "index_financor_counter_users_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_counter_users_on_user_id", using: :btree
  end

  create_table "financor_currency_rates", force: :cascade do |t|
    t.string   "bank",             limit: 255,                                      null: false
    t.date     "rate_date",                                                         null: false
    t.integer  "unit",                                                  default: 1
    t.string   "curr",             limit: 3,                                        null: false
    t.string   "bank_curr",        limit: 3
    t.decimal  "buying",                       precision: 10, scale: 5
    t.decimal  "selling",                      precision: 10, scale: 5
    t.decimal  "banknote_buying",              precision: 10, scale: 5
    t.decimal  "banknote_selling",             precision: 10, scale: 5
    t.decimal  "usd_rate",                     precision: 10, scale: 5
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["bank", "rate_date", "curr", "bank_curr"], name: "unique_on_bank_date_and_currencies", unique: true, using: :btree
  end

  create_table "financor_currency_valuations", force: :cascade do |t|
    t.date     "start_date"
    t.date     "finish_date"
    t.string   "start_account_code"
    t.string   "finish_account_code"
    t.string   "curr"
    t.date     "curr_date"
    t.integer  "patron_id"
    t.integer  "user_id"
    t.integer  "branch_id"
    t.integer  "profit_center_id"
    t.integer  "gldoc_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "operation_id"
    t.string   "curr_type",           limit: 20
    t.index ["operation_id"], name: "index_financor_currency_valuations_on_operation_id", using: :btree
    t.index ["patron_id"], name: "index_financor_currency_valuations_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_currency_valuations_on_user_id", using: :btree
  end

  create_table "financor_einvoice_accounts", force: :cascade do |t|
    t.string   "service_code"
    t.string   "service_uname"
    t.string   "service_pwd"
    t.integer  "patron_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.text     "einvoice_template"
    t.text     "earchive_template"
    t.string   "service_type"
    t.integer  "company_id"
    t.string   "email"
    t.text     "en_earchive_template"
    t.string   "status",               limit: 10, default: "active"
    t.index ["patron_id"], name: "index_financor_einvoice_accounts_on_patron_id", using: :btree
    t.index ["service_code"], name: "index_financor_einvoice_accounts_on_service_code", using: :btree
  end

  create_table "financor_einvoices", force: :cascade do |t|
    t.string   "uuid"
    t.string   "name"
    t.date     "issue_date"
    t.string   "einvoice_type"
    t.string   "einvoice_profile"
    t.text     "note"
    t.string   "doc_currency_code"
    t.string   "pay_currency_code"
    t.string   "supplier_website"
    t.string   "supplier_taxno"
    t.string   "supplier_name"
    t.string   "supplier_street"
    t.string   "supplier_build_no"
    t.string   "supplier_sub_name"
    t.string   "supplier_city"
    t.string   "supplier_country"
    t.string   "supplier_tax_office"
    t.string   "supplier_tel"
    t.string   "supplier_fax"
    t.string   "supplier_email"
    t.string   "customer_website"
    t.string   "customer_taxno"
    t.string   "customer_name"
    t.string   "customer_street"
    t.string   "customer_build_no"
    t.string   "customer_sub_name"
    t.string   "customer_city"
    t.string   "customer_country"
    t.string   "customer_region"
    t.string   "customer_postalzone"
    t.string   "customer_tax_office"
    t.string   "tax_type"
    t.string   "customer_tel"
    t.string   "customer_fax"
    t.string   "customer_email"
    t.string   "payment_code"
    t.string   "payment_due_date"
    t.decimal  "tax_amount",                        default: "0.0"
    t.decimal  "tax_exclusive_amount",              default: "0.0"
    t.decimal  "tax_inclusive_amount",              default: "0.0"
    t.string   "service_code",         limit: 10
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "company_id"
    t.integer  "invoice_id"
    t.string   "remote_service_id"
    t.string   "status",               limit: 1000
    t.string   "error_code"
    t.text     "error_message"
    t.integer  "patron_id"
    t.datetime "envelope_date"
    t.string   "reject_note",          limit: 255
    t.string   "service_name"
    t.index ["invoice_id"], name: "index_financor_einvoices_on_invoice_id", using: :btree
    t.index ["patron_id"], name: "index_financor_einvoices_on_patron_id", using: :btree
  end

  create_table "financor_einvolines", force: :cascade do |t|
    t.bigint   "line_number"
    t.integer  "einvoice_id"
    t.decimal  "invoiced_quantity"
    t.decimal  "line_extension_amount"
    t.decimal  "einvoline_tax_amount"
    t.decimal  "einvoline_taxable_amount"
    t.decimal  "einvoline_percent"
    t.string   "einvoline_name"
    t.string   "einvoline_tax_type_code"
    t.decimal  "einvoline_price_amount"
    t.string   "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "curr",                     limit: 50
    t.string   "other_tax_code",           limit: 50
    t.decimal  "other_percent"
    t.decimal  "other_taxable_amount"
    t.decimal  "other_tax_amount"
    t.string   "allowance_indicator",      limit: 20
    t.decimal  "allowance_multiplier"
    t.decimal  "allowance_amount"
  end

  create_table "financor_findoc_types", force: :cascade do |t|
    t.integer "patron_id",                                           null: false
    t.string  "name",                 limit: 50,                     null: false
    t.string  "doc_type",             limit: 50,                     null: false
    t.string  "debit_credit",         limit: 20
    t.string  "line_account_types",   limit: 500,                    null: false
    t.string  "status",               limit: 20,  default: "active", null: false
    t.string  "actual_status",        limit: 30
    t.string  "new_status",           limit: 30
    t.string  "header_account_type",  limit: 20
    t.string  "line_account_type",    limit: 20
    t.boolean "currency_transfer",                default: false
    t.boolean "approvable"
    t.boolean "ledgerable"
    t.boolean "includes_vat",                     default: false
    t.boolean "includes_doc_details",             default: false
    t.boolean "installable",                      default: false
    t.integer "ledger_group_id"
    t.boolean "profit_center",                    default: false
    t.string  "ledger_entry_type"
    t.string  "cheque_type"
    t.string  "payment_collection",   limit: 30
    t.string  "name_en",              limit: 50
    t.index ["ledger_group_id"], name: "index_financor_findoc_types_on_ledger_group_id", using: :btree
    t.index ["patron_id"], name: "index_financor_findoc_types_on_patron_id", using: :btree
  end

  create_table "financor_findoclines", force: :cascade do |t|
    t.integer  "patron_id",                                     null: false
    t.integer  "findoc_id",                                     null: false
    t.integer  "account_id",                                    null: false
    t.string   "account_code",      limit: 50,                  null: false
    t.string   "curr",                                          null: false
    t.decimal  "curr_rate",                     default: "1.0", null: false
    t.decimal  "debit",                         default: "0.0"
    t.decimal  "credit",                        default: "0.0"
    t.decimal  "debit_local",                   default: "0.0"
    t.decimal  "credit_local",                  default: "0.0"
    t.text     "notes"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.decimal  "debit_doc",                     default: "0.0"
    t.decimal  "credit_doc",                    default: "0.0"
    t.integer  "vat_id"
    t.decimal  "vat_amount",                    default: "0.0"
    t.string   "country_id",        limit: 50
    t.string   "doc_no",            limit: 50
    t.date     "doc_date"
    t.decimal  "remained_amount"
    t.string   "parent_type"
    t.integer  "parent_id"
    t.integer  "profit_center_id"
    t.integer  "ledger_account_id"
    t.date     "due_date"
    t.decimal  "vat_local",                     default: "0.0"
    t.integer  "bank_payment_id"
    t.decimal  "rap_curr_rate",                 default: "1.0"
    t.decimal  "rap2_curr_rate",                default: "1.0"
    t.string   "iban",              limit: 100
    t.string   "paid_type"
    t.integer  "paid_id"
    t.index ["account_id"], name: "index_financor_findoclines_on_account_id", using: :btree
    t.index ["findoc_id"], name: "index_financor_findoclines_on_findoc_id", using: :btree
    t.index ["ledger_account_id"], name: "index_financor_findoclines_on_ledger_account_id", using: :btree
    t.index ["paid_type", "paid_id"], name: "index_financor_findoclines_on_paid_type_and_paid_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_financor_findoclines_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_findoclines_on_patron_id", using: :btree
    t.index ["profit_center_id"], name: "index_financor_findoclines_on_profit_center_id", using: :btree
  end

  create_table "financor_findocs", force: :cascade do |t|
    t.integer  "patron_id",                                         null: false
    t.integer  "user_id",                                           null: false
    t.integer  "branch_id"
    t.string   "code",                 limit: 50,                   null: false
    t.string   "status",               limit: 50
    t.string   "doc_type",             limit: 50,                   null: false
    t.integer  "account_id"
    t.string   "account_code",         limit: 50
    t.date     "doc_date",                                          null: false
    t.date     "due_date"
    t.string   "curr",                                              null: false
    t.decimal  "curr_rate",                         default: "1.0", null: false
    t.decimal  "debit",                             default: "0.0"
    t.decimal  "credit",                            default: "0.0"
    t.decimal  "debit_local",                       default: "0.0"
    t.decimal  "credit_local",                      default: "0.0"
    t.text     "notes"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "dc",                   limit: 10,                   null: false
    t.integer  "findoc_type_id"
    t.integer  "expense_form_id"
    t.integer  "ledger_id"
    t.string   "parent_type"
    t.integer  "parent_id"
    t.boolean  "trashed",                           default: false
    t.integer  "approver_id"
    t.decimal  "vat_amount",                        default: "0.0"
    t.date     "ledger_date"
    t.integer  "cheque_id"
    t.integer  "profit_center_id"
    t.integer  "ledger_account_id"
    t.decimal  "cost",                              default: "0.0"
    t.string   "cost_curr",            limit: 3
    t.integer  "installment_count"
    t.integer  "operation_id"
    t.decimal  "vat_local",                         default: "0.0"
    t.decimal  "rap_curr_rate",                     default: "1.0"
    t.decimal  "rap2_curr_rate",                    default: "1.0"
    t.date     "approval_date"
    t.integer  "related_account_id"
    t.decimal  "cost_amount",                       default: "0.0"
    t.integer  "cost_account_id"
    t.decimal  "transfer_amount",                   default: "0.0"
    t.string   "transfer_curr",        limit: 3
    t.decimal  "transfer_curr_rate",                default: "1.0"
    t.integer  "bank_payment_id"
    t.string   "iban",                 limit: 100
    t.integer  "findoclines_count",                 default: 0
    t.string   "form_scope",           limit: 10
    t.string   "related_account_name", limit: 100
    t.string   "remote_service",       limit: 30
    t.string   "remote_id",            limit: 1000
    t.index ["account_id"], name: "index_financor_findocs_on_account_id", using: :btree
    t.index ["approver_id"], name: "index_financor_findocs_on_approver_id", using: :btree
    t.index ["cheque_id"], name: "index_financor_findocs_on_cheque_id", using: :btree
    t.index ["cost_account_id"], name: "index_financor_findocs_on_cost_account_id", using: :btree
    t.index ["expense_form_id"], name: "index_financor_findocs_on_expense_form_id", using: :btree
    t.index ["ledger_account_id"], name: "index_financor_findocs_on_ledger_account_id", using: :btree
    t.index ["ledger_id"], name: "index_financor_findocs_on_ledger_id", using: :btree
    t.index ["operation_id"], name: "index_financor_findocs_on_operation_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_financor_findocs_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_findocs_on_patron_id", using: :btree
    t.index ["profit_center_id"], name: "index_financor_findocs_on_profit_center_id", using: :btree
    t.index ["related_account_id"], name: "index_financor_findocs_on_related_account_id", using: :btree
    t.index ["user_id"], name: "index_financor_findocs_on_user_id", using: :btree
  end

  create_table "financor_finitem_groups", force: :cascade do |t|
    t.integer  "patron_id",              null: false
    t.integer  "user_id",                null: false
    t.string   "name",       limit: 100, null: false
    t.string   "notes"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["patron_id"], name: "index_financor_finitem_groups_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_finitem_groups_on_user_id", using: :btree
  end

  create_table "financor_finitems", force: :cascade do |t|
    t.string   "code",                limit: 255,                 null: false
    t.string   "name",                limit: 255,                 null: false
    t.string   "item_type",           limit: 50,                  null: false
    t.boolean  "salable",                         default: true
    t.decimal  "sales_price",                     default: "0.0"
    t.string   "sales_curr",          limit: 3
    t.integer  "sales_tax_id"
    t.integer  "sales_account_id"
    t.text     "sales_notes"
    t.boolean  "purchasable",                     default: true
    t.decimal  "purchase_price",                  default: "0.0"
    t.string   "purchase_curr",       limit: 3
    t.integer  "purchase_tax_id"
    t.integer  "purchase_account_id"
    t.text     "purchase_notes"
    t.boolean  "stockable",                       default: true
    t.string   "stock_unit",          limit: 30
    t.integer  "min_stock_unit",                  default: 0
    t.integer  "patron_id"
    t.integer  "user_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "finitem_group_id"
    t.string   "tax_er_code",         limit: 20
    t.string   "tax_er",              limit: 255
    t.string   "name_foreign",        limit: 255
    t.text     "integration_names"
    t.string   "involine_type",       limit: 30
    t.index ["finitem_group_id"], name: "index_financor_finitems_on_finitem_group_id", using: :btree
    t.index ["patron_id"], name: "index_financor_finitems_on_patron_id", using: :btree
    t.index ["purchase_account_id"], name: "index_financor_finitems_on_purchase_account_id", using: :btree
    t.index ["sales_account_id"], name: "index_financor_finitems_on_sales_account_id", using: :btree
    t.index ["user_id"], name: "index_financor_finitems_on_user_id", using: :btree
  end

  create_table "financor_finloads", force: :cascade do |t|
    t.string   "parent_type",                          null: false
    t.integer  "parent_id",                            null: false
    t.integer  "patron_id",                            null: false
    t.decimal  "estimated_debit_eur",  default: "0.0"
    t.decimal  "estimated_credit_eur", default: "0.0"
    t.decimal  "invoiced_debit_eur",   default: "0.0"
    t.decimal  "invoiced_credit_eur",  default: "0.0"
    t.decimal  "estimated_debit_usd",  default: "0.0"
    t.decimal  "estimated_credit_usd", default: "0.0"
    t.decimal  "invoiced_debit_usd",   default: "0.0"
    t.decimal  "invoiced_credit_usd",  default: "0.0"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["parent_type", "parent_id"], name: "index_financor_finloads_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_finloads_on_patron_id", using: :btree
  end

  create_table "financor_finpoints", force: :cascade do |t|
    t.string   "title",          limit: 100,                    null: false
    t.string   "point_type",     limit: 30,                     null: false
    t.string   "curr",           limit: 3
    t.string   "reference",      limit: 50
    t.string   "bank",           limit: 100
    t.integer  "branch_id"
    t.integer  "manager_id"
    t.integer  "patron_id",                                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                                       null: false
    t.boolean  "use_on_invoice",             default: false
    t.string   "status",                     default: "active"
    t.string   "account_type",               default: "public"
    t.index ["branch_id"], name: "index_financor_finpoints_on_branch_id", using: :btree
    t.index ["manager_id"], name: "index_financor_finpoints_on_manager_id", using: :btree
    t.index ["patron_id"], name: "index_financor_finpoints_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_finpoints_on_user_id", using: :btree
  end

  create_table "financor_gldefheads", force: :cascade do |t|
    t.string   "name"
    t.string   "category",   limit: 100
    t.text     "notes"
    t.integer  "patron_id",              null: false
    t.integer  "user_id",                null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["category"], name: "index_financor_gldefheads_on_category", using: :btree
    t.index ["patron_id"], name: "index_financor_gldefheads_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_gldefheads_on_user_id", using: :btree
  end

  create_table "financor_gldefs", force: :cascade do |t|
    t.string   "debit_credit",        limit: 10
    t.string   "line_count_type",     limit: 20
    t.string   "amount_type",         limit: 20
    t.string   "ledger_account_code", limit: 50
    t.string   "profit_center_code",  limit: 50
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "parent_type"
    t.integer  "parent_id"
    t.integer  "gldefhead_id"
    t.index ["gldefhead_id"], name: "index_financor_gldefs_on_gldefhead_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_financor_gldefs_on_parent_type_and_parent_id", using: :btree
  end

  create_table "financor_gldoclines", id: :bigserial, force: :cascade do |t|
    t.integer  "gldoc_id",                                        null: false
    t.integer  "account_id"
    t.string   "account_code"
    t.string   "curr"
    t.decimal  "curr_rate"
    t.decimal  "debit",                           default: "0.0"
    t.decimal  "credit",                          default: "0.0"
    t.decimal  "debit_local",                     default: "0.0"
    t.decimal  "credit_local",                    default: "0.0"
    t.text     "notes"
    t.string   "line_doc_no"
    t.date     "line_doc_date"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "profit_center_id"
    t.date     "due_date"
    t.integer  "ledger_account_id"
    t.string   "ledger_account_code", limit: 100
    t.string   "accountable_model",   limit: 20
    t.decimal  "rap_curr_rate",                   default: "1.0"
    t.decimal  "rap2_curr_rate",                  default: "1.0"
    t.string   "local_curr",          limit: 3
    t.string   "uuid",                limit: 255
    t.index ["account_id"], name: "index_financor_gldoclines_on_account_id", using: :btree
    t.index ["gldoc_id"], name: "index_financor_gldoclines_on_gldoc_id", using: :btree
    t.index ["profit_center_id"], name: "index_financor_gldoclines_on_profit_center_id", using: :btree
  end

  create_table "financor_gldocs", force: :cascade do |t|
    t.string   "title",                                      null: false
    t.date     "doc_date"
    t.string   "status",       limit: 20, default: "draft",  null: false
    t.integer  "patron_id",                                  null: false
    t.integer  "user_id",                                    null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "ledger_id"
    t.date     "ledger_date"
    t.integer  "branch_id"
    t.string   "parent_type"
    t.integer  "parent_id"
    t.integer  "gldefhead_id"
    t.string   "ledger_type",  limit: 20, default: "Mahsup"
    t.integer  "operation_id"
    t.date     "due_date"
    t.index ["branch_id"], name: "index_financor_gldocs_on_branch_id", using: :btree
    t.index ["gldefhead_id"], name: "index_financor_gldocs_on_gldefhead_id", using: :btree
    t.index ["operation_id"], name: "index_financor_gldocs_on_operation_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_financor_gldocs_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_gldocs_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_gldocs_on_user_id", using: :btree
  end

  create_table "financor_ibans", force: :cascade do |t|
    t.integer  "patron_id",                                null: false
    t.integer  "user_id",                                  null: false
    t.string   "parent_type",                              null: false
    t.integer  "parent_id",                                null: false
    t.string   "no",            limit: 50,                 null: false
    t.string   "curr",          limit: 3,                  null: false
    t.boolean  "is_default",               default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "bank_name"
    t.string   "id_number"
    t.string   "title"
    t.integer  "bank_id"
    t.string   "bank_code"
    t.string   "branch_code"
    t.string   "customer_code"
    t.string   "account_code"
    t.index ["bank_id"], name: "index_financor_ibans_on_bank_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_financor_ibans_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_ibans_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_ibans_on_user_id", using: :btree
  end

  create_table "financor_invoice_counters", force: :cascade do |t|
    t.integer  "patron_id"
    t.string   "code",                limit: 50
    t.string   "invoice_type",        limit: 20
    t.string   "prefix",              limit: 20
    t.integer  "count"
    t.integer  "branch_id"
    t.integer  "number_length"
    t.integer  "current_year"
    t.boolean  "auto_year_transfer",             default: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.date     "last_invoice_date",              default: -> { "now()" }
    t.integer  "einvoice_account_id"
    t.index ["patron_id"], name: "index_financor_invoice_counters_on_patron_id", using: :btree
  end

  create_table "financor_invoice_customers", force: :cascade do |t|
    t.string   "identifier",         limit: 30,                 null: false
    t.string   "postbox_alias",      limit: 255,                null: false
    t.string   "title",              limit: 255
    t.string   "company_type",       limit: 20
    t.datetime "system_create_date"
    t.datetime "first_create_date"
    t.boolean  "enabled",                        default: true
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["identifier", "postbox_alias"], name: "financor_invoice_customers_unique", unique: true, using: :btree
    t.index ["identifier"], name: "index_financor_invoice_customers_on_identifier", using: :btree
  end

  create_table "financor_invoice_details", force: :cascade do |t|
    t.integer  "invoice_id",                                         null: false
    t.integer  "position_id"
    t.integer  "loading_id"
    t.string   "voyage",             limit: 100
    t.string   "truck",              limit: 100
    t.string   "vessel",             limit: 100
    t.string   "load_coun",          limit: 5
    t.string   "unload_coun",        limit: 5
    t.string   "doc_type",           limit: 255
    t.integer  "operation_id"
    t.integer  "km"
    t.date     "operation_date"
    t.string   "operation_ref",      limit: 30
    t.integer  "load_custom_id"
    t.integer  "unload_custom_id"
    t.string   "border_gate",        limit: 100
    t.integer  "route"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "waybill_no",         limit: 50
    t.date     "border_date"
    t.boolean  "included",                       default: true
    t.string   "vehicle_owner_type", limit: 30
    t.integer  "patron_id"
    t.integer  "unit_number",                    default: 1
    t.string   "unit_type",          limit: 10
    t.string   "border_code",        limit: 10
    t.string   "taxoffice",          limit: 50
    t.string   "taxoffice_code",     limit: 10
    t.boolean  "analyzed",                       default: false
    t.integer  "supplier_id"
    t.string   "status",             limit: 10,  default: "pending"
    t.index ["invoice_id"], name: "index_financor_invoice_details_on_invoice_id", using: :btree
    t.index ["loading_id"], name: "index_financor_invoice_details_on_loading_id", using: :btree
    t.index ["patron_id"], name: "index_financor_invoice_details_on_patron_id", using: :btree
    t.index ["position_id"], name: "index_financor_invoice_details_on_position_id", using: :btree
    t.index ["supplier_id"], name: "index_financor_invoice_details_on_supplier_id", using: :btree
  end

  create_table "financor_invoices", force: :cascade do |t|
    t.string   "uuid",                limit: 255,                    null: false
    t.string   "name",                limit: 30,                     null: false
    t.integer  "company_id",                                         null: false
    t.date     "invoice_date",                                       null: false
    t.string   "invoice_type",        limit: 20,                     null: false
    t.string   "debit_credit",        limit: 10,                     null: false
    t.string   "curr",                limit: 3,                      null: false
    t.decimal  "curr_rate",                                          null: false
    t.decimal  "invoice_amount",                  default: "0.0",    null: false
    t.decimal  "taxfree_amount",                  default: "0.0"
    t.decimal  "taxed_amount",                    default: "0.0"
    t.decimal  "tax_amount",                      default: "0.0"
    t.decimal  "discount_rate",                   default: "0.0"
    t.decimal  "discount_amount",                 default: "0.0"
    t.integer  "payment_terms",                   default: 0
    t.date     "due_date"
    t.string   "status",              limit: 10,  default: "active"
    t.text     "notes"
    t.string   "invoiced_type",       limit: 30
    t.integer  "invoiced_id"
    t.integer  "user_id",                                            null: false
    t.integer  "patron_id",                                          null: false
    t.string   "remote_id",           limit: 255
    t.integer  "involines_count",                 default: 0
    t.integer  "comments_count",                  default: 0
    t.boolean  "trashed",                         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invoice_title",       limit: 255
    t.string   "invoice_taxno",       limit: 20
    t.string   "invoice_taxoffice",   limit: 40
    t.string   "invoice_country_id",  limit: 2
    t.string   "invoice_city",        limit: 50
    t.text     "invoice_address"
    t.integer  "branch_id"
    t.integer  "ledger_id"
    t.integer  "approver_id"
    t.integer  "finpoint_id"
    t.decimal  "remained_amount"
    t.integer  "profit_center_id"
    t.date     "ledger_date"
    t.integer  "operation_id"
    t.boolean  "use_account",                     default: false
    t.string   "work_type",           limit: 20
    t.string   "einvoice_status",     limit: 100
    t.string   "einvoice_postbox",    limit: 255
    t.decimal  "rap_curr_rate",                   default: "1.0"
    t.decimal  "rap2_curr_rate",                  default: "1.0"
    t.string   "account_type"
    t.integer  "account_id"
    t.integer  "expense_form_id"
    t.date     "approval_date"
    t.integer  "payment_approver_id"
    t.date     "payment_approved_at"
    t.integer  "ledger_approver_id"
    t.date     "ledger_approved_at"
    t.boolean  "paid",                            default: false
    t.integer  "ref_invoice_id"
    t.date     "operation_date"
    t.string   "operation_type",      limit: 10
    t.date     "received_at"
    t.text     "einvoice_notes"
    t.index ["approver_id"], name: "index_financor_invoices_on_approver_id", using: :btree
    t.index ["branch_id"], name: "index_financor_invoices_on_branch_id", using: :btree
    t.index ["company_id"], name: "index_financor_invoices_on_company_id", using: :btree
    t.index ["debit_credit"], name: "index_financor_invoices_on_debit_credit", using: :btree
    t.index ["expense_form_id"], name: "index_financor_invoices_on_expense_form_id", using: :btree
    t.index ["finpoint_id"], name: "index_financor_invoices_on_finpoint_id", using: :btree
    t.index ["invoice_taxno"], name: "index_financor_invoices_on_invoice_taxno", using: :btree
    t.index ["invoiced_type", "invoiced_id"], name: "index_financor_invoices_on_invoiced_type_and_invoiced_id", using: :btree
    t.index ["ledger_approver_id"], name: "index_financor_invoices_on_ledger_approver_id", using: :btree
    t.index ["ledger_id"], name: "index_financor_invoices_on_ledger_id", using: :btree
    t.index ["operation_id"], name: "index_financor_invoices_on_operation_id", using: :btree
    t.index ["patron_id"], name: "index_financor_invoices_on_patron_id", using: :btree
    t.index ["payment_approver_id"], name: "index_financor_invoices_on_payment_approver_id", using: :btree
    t.index ["profit_center_id"], name: "index_financor_invoices_on_profit_center_id", using: :btree
    t.index ["ref_invoice_id"], name: "index_financor_invoices_on_ref_invoice_id", using: :btree
  end

  create_table "financor_involines", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "company_id",                                          null: false
    t.string   "name",                    limit: 255,                 null: false
    t.string   "debit_credit",            limit: 10,                  null: false
    t.string   "line_type",               limit: 30
    t.string   "curr",                    limit: 3,                   null: false
    t.decimal  "curr_rate",                           default: "1.0", null: false
    t.decimal  "invoice_rate",                        default: "1.0", null: false
    t.decimal  "unit_number",                         default: "1.0"
    t.string   "unit_type",               limit: 20
    t.decimal  "unit_price",                          default: "0.0"
    t.decimal  "total_amount",                        default: "0.0", null: false
    t.decimal  "discount_rate",                       default: "0.0"
    t.decimal  "discount_amount",                     default: "0.0"
    t.decimal  "vat_rate",                            default: "0.0"
    t.decimal  "vat_amount",                          default: "0.0"
    t.string   "vat_code",                limit: 20
    t.string   "notes",                   limit: 255
    t.integer  "user_id",                                             null: false
    t.integer  "patron_id",                                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.string   "parent_type",             limit: 255
    t.integer  "vat_id"
    t.integer  "finitem_id"
    t.decimal  "total_amount_local",                  default: "0.0"
    t.decimal  "total_amount_invoice",                default: "0.0"
    t.decimal  "discount_amount_local",               default: "0.0"
    t.decimal  "discount_amount_invoice",             default: "0.0"
    t.decimal  "vat_amount_local",                    default: "0.0"
    t.decimal  "vat_amount_invoice",                  default: "0.0"
    t.decimal  "line_total",                          default: "0.0"
    t.decimal  "line_total_local",                    default: "0.0"
    t.decimal  "line_total_invoice",                  default: "0.0"
    t.integer  "profit_center_id"
    t.integer  "operation_id"
    t.integer  "ledger_account_id"
    t.string   "tax_er_code",             limit: 20
    t.string   "tax_er",                  limit: 255
    t.decimal  "rap_curr_rate",                       default: "1.0"
    t.decimal  "rap2_curr_rate",                      default: "1.0"
    t.string   "country_id",              limit: 2
    t.string   "doc_no",                  limit: 30
    t.date     "doc_date"
    t.string   "supplier_title",          limit: 100
    t.string   "supplier_taxno",          limit: 20
    t.string   "supplier_taxoffice",      limit: 40
    t.string   "supplier_address",        limit: 100
    t.string   "vehicle_codes",           limit: 255
    t.index ["company_id"], name: "index_financor_involines_on_company_id", using: :btree
    t.index ["finitem_id"], name: "index_financor_involines_on_finitem_id", using: :btree
    t.index ["invoice_id"], name: "index_financor_involines_on_invoice_id", using: :btree
    t.index ["operation_id"], name: "index_financor_involines_on_operation_id", using: :btree
    t.index ["parent_id", "parent_type"], name: "index_financor_involines_on_parent_id_and_parent_type", using: :btree
    t.index ["patron_id"], name: "index_financor_involines_on_patron_id", using: :btree
    t.index ["profit_center_id"], name: "index_financor_involines_on_profit_center_id", using: :btree
  end

  create_table "financor_ledger_accounts", force: :cascade do |t|
    t.string   "code",                   limit: 50,                          null: false
    t.string   "name",                                                       null: false
    t.integer  "fiscal_year",                                                null: false
    t.string   "parent_code",            limit: 50
    t.string   "status",                 limit: 10, default: "active"
    t.string   "curr",                   limit: 3
    t.integer  "level",                             default: 1
    t.boolean  "ledgerable",                        default: false
    t.string   "notes"
    t.integer  "parent_id"
    t.integer  "patron_id",                                                  null: false
    t.integer  "user_id",                                                    null: false
    t.datetime "created_at",                        default: -> { "now()" }, null: false
    t.datetime "updated_at",                        default: -> { "now()" }, null: false
    t.string   "parent_ids",             limit: 30
    t.integer  "comments_count",                    default: 0
    t.integer  "accounts_count",                    default: 0
    t.boolean  "is_partner",                        default: false
    t.string   "account_type",                      default: "public"
    t.text     "finnotes"
    t.string   "color"
    t.boolean  "close_by_profit_center",            default: false
    t.index ["code"], name: "index_financor_ledger_accounts_on_code", using: :btree
    t.index ["fiscal_year"], name: "index_financor_ledger_accounts_on_fiscal_year", using: :btree
    t.index ["parent_id"], name: "index_financor_ledger_accounts_on_parent_id", using: :btree
    t.index ["patron_id", "code"], name: "index_financor_ledger_account_on_code_and_patron_id", unique: true, using: :btree
    t.index ["patron_id"], name: "index_financor_ledger_accounts_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_ledger_accounts_on_user_id", using: :btree
  end

  create_table "financor_ledger_books", force: :cascade do |t|
    t.date     "start_date"
    t.date     "finish_date"
    t.string   "status",                   default: "pending"
    t.text     "service_notes"
    t.integer  "user_id"
    t.integer  "patron_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "action_type",   limit: 10
    t.index ["patron_id"], name: "index_financor_ledger_books_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_ledger_books_on_user_id", using: :btree
  end

  create_table "financor_ledger_closings", force: :cascade do |t|
    t.integer  "order_no"
    t.string   "account_code"
    t.integer  "transfer_account_id"
    t.integer  "fiscal_year"
    t.text     "notes"
    t.integer  "patron_id",           null: false
    t.integer  "user_id",             null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["patron_id"], name: "index_financor_ledger_closings_on_patron_id", using: :btree
    t.index ["transfer_account_id"], name: "index_financor_ledger_closings_on_transfer_account_id", using: :btree
    t.index ["user_id"], name: "index_financor_ledger_closings_on_user_id", using: :btree
  end

  create_table "financor_ledger_entries", force: :cascade do |t|
    t.integer  "parent_id",                                     null: false
    t.string   "parent_type",       limit: 255,                 null: false
    t.integer  "doc_id",                                        null: false
    t.string   "doc_type",          limit: 40
    t.date     "entry_date",                                    null: false
    t.date     "due_date"
    t.date     "payment_date"
    t.integer  "account_id"
    t.integer  "ledger_account_id"
    t.integer  "profit_center_id"
    t.decimal  "debit",                         default: "0.0"
    t.decimal  "credit",                        default: "0.0"
    t.decimal  "local_debit",                   default: "0.0"
    t.decimal  "local_credit",                  default: "0.0"
    t.string   "curr",              limit: 3
    t.decimal  "curr_rate",                     default: "1.0"
    t.decimal  "remained_debit",                default: "0.0"
    t.decimal  "remained_credit",               default: "0.0"
    t.integer  "comments_count",                default: 0
    t.integer  "branch_id",                                     null: false
    t.integer  "patron_id",                                     null: false
    t.integer  "user_id",                                       null: false
    t.text     "notes"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "doc_no",            limit: 50
    t.string   "doc_name",          limit: 100
    t.string   "account_code"
    t.decimal  "rap_curr_rate",                 default: "1.0"
    t.decimal  "rap2_curr_rate",                default: "1.0"
    t.string   "color",             limit: 20
    t.date     "batch_date"
    t.integer  "agreement_id"
    t.integer  "operation_id"
    t.integer  "line_no",                       default: 1
    t.index ["account_id"], name: "index_financor_ledger_entries_on_account_id", using: :btree
    t.index ["agreement_id"], name: "index_financor_ledger_entries_on_agreement_id", using: :btree
    t.index ["branch_id"], name: "index_financor_ledger_entries_on_branch_id", using: :btree
    t.index ["doc_id"], name: "index_financor_ledger_entries_on_doc_id", using: :btree
    t.index ["doc_type", "doc_id", "line_no"], name: "index_ledger_entries_unique_doc", unique: true, using: :btree
    t.index ["ledger_account_id"], name: "index_financor_ledger_entries_on_ledger_account_id", using: :btree
    t.index ["operation_id"], name: "index_financor_ledger_entries_on_operation_id", using: :btree
    t.index ["parent_id"], name: "index_financor_ledger_entries_on_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_ledger_entries_on_patron_id", using: :btree
    t.index ["profit_center_id"], name: "index_financor_ledger_entries_on_profit_center_id", using: :btree
    t.index ["user_id"], name: "index_financor_ledger_entries_on_user_id", using: :btree
  end

  create_table "financor_ledger_groups", force: :cascade do |t|
    t.string   "name",         limit: 100, null: false
    t.integer  "branch_id"
    t.integer  "patron_id",                null: false
    t.integer  "user_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "doc_type"
    t.string   "debit_credit"
    t.string   "i18n_code"
    t.index ["branch_id"], name: "index_financor_ledger_groups_on_branch_id", using: :btree
    t.index ["patron_id"], name: "index_financor_ledger_groups_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_ledger_groups_on_user_id", using: :btree
  end

  create_table "financor_ledger_histories", force: :cascade do |t|
    t.integer "ledger_id"
    t.string  "doc_type",                   null: false
    t.integer "doc_id",                     null: false
    t.integer "ledger_no"
    t.string  "action",          limit: 10
    t.date    "ledger_date"
    t.json    "ledger_data"
    t.integer "ledger_group_id"
    t.integer "user_id"
    t.integer "patron_id"
    t.date    "deleted_date"
    t.integer "deleted_user_id"
    t.index ["action"], name: "index_financor_ledger_histories_on_action", using: :btree
    t.index ["deleted_date"], name: "index_financor_ledger_histories_on_deleted_date", using: :btree
    t.index ["deleted_user_id"], name: "index_financor_ledger_histories_on_deleted_user_id", using: :btree
    t.index ["doc_type", "doc_id"], name: "index_financor_ledger_histories_on_doc_type_and_doc_id", using: :btree
    t.index ["ledger_date"], name: "index_financor_ledger_histories_on_ledger_date", using: :btree
    t.index ["ledger_group_id"], name: "index_financor_ledger_histories_on_ledger_group_id", using: :btree
    t.index ["ledger_id"], name: "index_financor_ledger_histories_on_ledger_id", using: :btree
    t.index ["patron_id"], name: "index_financor_ledger_histories_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_ledger_histories_on_user_id", using: :btree
  end

  create_table "financor_ledger_sums", force: :cascade do |t|
    t.date     "ledger_date",                                    null: false
    t.integer  "fiscal_year_id",                                 null: false
    t.integer  "ledger_account_id",                              null: false
    t.string   "ledger_account_code", limit: 50,                 null: false
    t.string   "curr",                limit: 3,                  null: false
    t.decimal  "debit",                          default: "0.0"
    t.decimal  "credit",                         default: "0.0"
    t.decimal  "debit_local",                    default: "0.0"
    t.decimal  "credit_local",                   default: "0.0"
    t.integer  "patron_id",                                      null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "profit_center_id"
    t.string   "ledger_type",         limit: 10,                 null: false
    t.decimal  "usd_debit",                      default: "0.0"
    t.decimal  "usd_credit",                     default: "0.0"
    t.decimal  "eur_debit",                      default: "0.0"
    t.decimal  "eur_credit",                     default: "0.0"
    t.index ["fiscal_year_id"], name: "index_financor_ledger_sums_on_fiscal_year_id", using: :btree
    t.index ["ledger_account_code"], name: "index_financor_ledger_sums_on_ledger_account_code", using: :btree
    t.index ["ledger_account_id"], name: "index_financor_ledger_sums_on_ledger_account_id", using: :btree
    t.index ["ledger_date", "ledger_account_id", "curr", "ledger_type"], name: "index_on_ledger_date_and_ledger_account_id_and_curr", unique: true, using: :btree
    t.index ["ledger_date"], name: "index_financor_ledger_sums_on_ledger_date", using: :btree
    t.index ["patron_id"], name: "index_financor_ledger_sums_on_patron_id", using: :btree
    t.index ["profit_center_id"], name: "index_financor_ledger_sums_on_profit_center_id", using: :btree
  end

  create_table "financor_ledger_sums_backup", force: :cascade do |t|
    t.date     "ledger_date",                                    null: false
    t.integer  "fiscal_year_id",                                 null: false
    t.integer  "ledger_account_id",                              null: false
    t.string   "ledger_account_code", limit: 50,                 null: false
    t.string   "curr",                limit: 3,                  null: false
    t.decimal  "debit",                          default: "0.0"
    t.decimal  "credit",                         default: "0.0"
    t.decimal  "debit_local",                    default: "0.0"
    t.decimal  "credit_local",                   default: "0.0"
    t.integer  "patron_id",                                      null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "profit_center_id"
  end

  create_table "financor_ledgerline_joiners", force: :cascade do |t|
    t.integer  "patron_id",     null: false
    t.integer  "user_id"
    t.integer  "source_id"
    t.decimal  "source_amount"
    t.integer  "target_id"
    t.decimal  "target_amount"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["patron_id"], name: "index_financor_ledgerline_joiners_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_ledgerline_joiners_on_user_id", using: :btree
  end

  create_table "financor_ledgerlines", force: :cascade do |t|
    t.integer  "patron_id",                                     null: false
    t.integer  "ledger_id",                                     null: false
    t.integer  "doc_id"
    t.string   "doc_type",          limit: 255
    t.string   "doc_no",            limit: 255
    t.integer  "source_id"
    t.string   "source_type",       limit: 255
    t.integer  "account_id"
    t.string   "account_code",      limit: 255,                 null: false
    t.string   "curr",                                          null: false
    t.decimal  "curr_rate",                     default: "1.0", null: false
    t.decimal  "debit",                         default: "0.0"
    t.decimal  "credit",                        default: "0.0"
    t.decimal  "debit_local",                   default: "0.0"
    t.decimal  "credit_local",                  default: "0.0"
    t.text     "notes"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.decimal  "paid"
    t.integer  "ledger_account_id",                             null: false
    t.integer  "profit_center_id",                              null: false
    t.date     "due_date"
    t.integer  "line_number"
    t.decimal  "rap_curr_rate",                 default: "1.0"
    t.decimal  "rap2_curr_rate",                default: "1.0"
    t.decimal  "usd_debit",                     default: "0.0"
    t.decimal  "usd_credit",                    default: "0.0"
    t.decimal  "eur_debit",                     default: "0.0"
    t.decimal  "eur_credit",                    default: "0.0"
    t.index ["account_code"], name: "index_financor_ledgerlines_on_account_code", using: :btree
    t.index ["doc_id"], name: "index_financor_ledgerlines_on_doc_id", using: :btree
    t.index ["doc_type"], name: "index_financor_ledgerlines_on_doc_type", using: :btree
    t.index ["ledger_account_id"], name: "index_financor_ledgerlines_on_ledger_account_id", using: :btree
    t.index ["ledger_id"], name: "index_financor_ledgerlines_on_ledger_id", using: :btree
    t.index ["patron_id"], name: "index_financor_ledgerlines_on_patron_id", using: :btree
    t.index ["profit_center_id"], name: "index_financor_ledgerlines_on_profit_center_id", using: :btree
    t.index ["source_type", "source_id"], name: "index_financor_ledgerlines_on_source_type_source_id", using: :btree
  end

  create_table "financor_ledgers", force: :cascade do |t|
    t.integer  "patron_id",                                         null: false
    t.integer  "user_id",                                           null: false
    t.integer  "ledger_year_id"
    t.string   "ledger_type",        limit: 20
    t.date     "ledger_date"
    t.integer  "ledger_no"
    t.text     "notes"
    t.integer  "doc_id",                                            null: false
    t.string   "doc_type",           limit: 255
    t.decimal  "debit_local",                    default: "0.0"
    t.decimal  "credit_local",                   default: "0.0"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "ledger_group_id"
    t.integer  "branch_id"
    t.string   "action_type",                    default: "active"
    t.integer  "entry_number_count"
    t.integer  "operation_id"
    t.string   "doc_no"
    t.date     "doc_date"
    t.integer  "operator_id",                                       null: false
    t.index ["branch_id"], name: "index_financor_ledgers_on_branch_id", using: :btree
    t.index ["doc_type", "doc_id"], name: "doc_type_id_must_be_unique", unique: true, using: :btree
    t.index ["doc_type", "doc_id"], name: "index_financor_ledgers_on_doc_type_doc_id", using: :btree
    t.index ["ledger_group_id"], name: "index_financor_ledgers_on_ledger_group_id", using: :btree
    t.index ["ledger_year_id", "patron_id", "entry_number_count"], name: "ledger_entry_must_be_unique", unique: true, using: :btree
    t.index ["operation_id"], name: "index_financor_ledgers_on_operation_id", using: :btree
    t.index ["operator_id"], name: "index_financor_ledgers_on_operator_id", using: :btree
    t.index ["patron_id"], name: "index_financor_ledgers_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_ledgers_on_user_id", using: :btree
  end

  create_table "financor_mappings", force: :cascade do |t|
    t.integer  "findocline_id"
    t.decimal  "findocline_amount"
    t.string   "findocline_curr",   limit: 3
    t.integer  "invoice_id"
    t.decimal  "invoice_amount"
    t.string   "invoice_curr",      limit: 3
    t.decimal  "conversion_rate"
    t.text     "notes"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "patron_id",                                   null: false
    t.integer  "debit_entry_id"
    t.decimal  "debit_amount",                default: "0.0"
    t.integer  "credit_entry_id"
    t.decimal  "credit_amount",               default: "0.0"
    t.index ["credit_entry_id"], name: "index_financor_mappings_on_credit_entry_id", using: :btree
    t.index ["debit_entry_id"], name: "index_financor_mappings_on_debit_entry_id", using: :btree
    t.index ["findocline_id"], name: "index_financor_mappings_on_findocline_id", using: :btree
    t.index ["invoice_id"], name: "index_financor_mappings_on_invoice_id", using: :btree
    t.index ["patron_id"], name: "index_financor_mappings_on_patron_id", using: :btree
  end

  create_table "financor_pay_schedules", force: :cascade do |t|
    t.integer  "patron_id",              null: false
    t.datetime "action_date"
    t.string   "status",      limit: 50
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["patron_id"], name: "index_financor_pay_schedules_on_patron_id", using: :btree
  end

  create_table "financor_pay_term_lines", force: :cascade do |t|
    t.integer  "pay_term_id",                                             null: false
    t.date     "due_date"
    t.decimal  "debit",                                default: "0.0"
    t.decimal  "credit",                               default: "0.0"
    t.decimal  "amount",                               default: "0.0"
    t.integer  "account_id"
    t.string   "account_code",             limit: 30
    t.string   "status",                   limit: 10,  default: "active"
    t.string   "notes",                    limit: 500
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.decimal  "amount_ins"
    t.decimal  "cost",                                 default: "0.0"
    t.string   "cost_curr",                limit: 3
    t.integer  "amount_center_id"
    t.integer  "cost_center_id"
    t.integer  "amount_debit_account_id"
    t.integer  "amount_credit_account_id"
    t.integer  "cost_debit_account_id"
    t.integer  "cost_credit_account_id"
    t.integer  "line_account_id"
    t.integer  "findoc_id"
    t.decimal  "payed_amount",                         default: "0.0"
    t.index ["due_date"], name: "index_financor_pay_term_lines_on_due_date", using: :btree
    t.index ["findoc_id"], name: "index_financor_pay_term_lines_on_findoc_id", using: :btree
    t.index ["pay_term_id"], name: "index_financor_pay_term_lines_on_pay_term_id", using: :btree
  end

  create_table "financor_pay_terms", force: :cascade do |t|
    t.integer  "patron_id",                                                  null: false
    t.integer  "user_id",                                                    null: false
    t.integer  "account_id",                                                 null: false
    t.string   "account_code",                limit: 30
    t.string   "account_name",                limit: 100
    t.string   "pay_term_type",               limit: 20
    t.string   "doc_type",                    limit: 20
    t.string   "doc_no",                      limit: 40
    t.date     "doc_date"
    t.string   "debit_credit",                limit: 20
    t.decimal  "debit",                                   default: "0.0"
    t.decimal  "credit",                                  default: "0.0"
    t.decimal  "amount",                                  default: "0.0"
    t.string   "curr",                        limit: 10
    t.date     "due_date"
    t.string   "notes",                       limit: 500
    t.string   "parent_type"
    t.integer  "parent_id"
    t.string   "status",                                  default: "active"
    t.integer  "instalment_count",                        default: 1
    t.string   "amount_type",                 limit: 20
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.decimal  "cost",                                    default: "0.0"
    t.string   "cost_curr",                   limit: 3
    t.string   "import_file"
    t.integer  "ledger_id"
    t.integer  "ty_amount_debit_account_id"
    t.integer  "ny_amount_debit_account_id"
    t.integer  "ty_amount_credit_account_id"
    t.integer  "ny_amount_credit_account_id"
    t.integer  "amount_center_id"
    t.integer  "cost_center_id"
    t.integer  "ty_cost_debit_account_id"
    t.integer  "ty_cost_credit_account_id"
    t.integer  "ny_cost_debit_account_id"
    t.integer  "ny_cost_credit_account_id"
    t.integer  "line_account_id"
    t.date     "ledger_date"
    t.integer  "findoc_type_id"
    t.integer  "branch_id"
    t.integer  "parent_pay_term_id"
    t.date     "cancel_date"
    t.integer  "previous_ledger_id"
    t.text     "cancel_note"
    t.date     "finish_date"
    t.boolean  "cashflow_effected",                       default: true
    t.decimal  "curr_rate",                               default: "1.0"
    t.decimal  "cost_curr_rate",                          default: "1.0"
    t.string   "credit_type",                 limit: 50
    t.decimal  "interest_rate"
    t.string   "payment_type"
    t.integer  "approver_id"
    t.datetime "approval_date"
    t.index ["account_id"], name: "index_financor_pay_terms_on_account_id", using: :btree
    t.index ["branch_id"], name: "index_financor_pay_terms_on_branch_id", using: :btree
    t.index ["findoc_type_id"], name: "index_financor_pay_terms_on_findoc_type_id", using: :btree
    t.index ["ledger_id"], name: "index_financor_pay_terms_on_ledger_id", using: :btree
    t.index ["parent_pay_term_id"], name: "index_financor_pay_terms_on_parent_pay_term_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_financor_pay_terms_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_pay_terms_on_patron_id", using: :btree
    t.index ["previous_ledger_id"], name: "index_financor_pay_terms_on_previous_ledger_id", using: :btree
    t.index ["user_id"], name: "index_financor_pay_terms_on_user_id", using: :btree
  end

  create_table "financor_payment_collections", force: :cascade do |t|
    t.integer  "patron_id",                                    null: false
    t.integer  "user_id",                                      null: false
    t.integer  "company_id"
    t.string   "docno",            limit: 40
    t.string   "debit_credit",     limit: 20
    t.decimal  "debit",                        default: "0.0"
    t.decimal  "credit",                       default: "0.0"
    t.string   "curr",             limit: 10
    t.date     "doc_date"
    t.date     "due_date"
    t.string   "notes",            limit: 500
    t.string   "doc_type",         limit: 20
    t.string   "parent_type",      limit: 30
    t.integer  "parent_id"
    t.integer  "account_id"
    t.string   "account_code",     limit: 30
    t.integer  "parentline_id"
    t.string   "company_name",     limit: 100
    t.integer  "pay_account_id"
    t.string   "pay_account_code", limit: 50
    t.boolean  "paid",                         default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["parent_type", "parent_id"], name: "index_financor_payment_collections_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_payment_collections_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_payment_collections_on_user_id", using: :btree
  end

  create_table "financor_proctaxes", force: :cascade do |t|
    t.string   "reference",  limit: 100
    t.string   "doc_no",     limit: 100
    t.date     "doc_date"
    t.decimal  "tax_base",               default: "0.0"
    t.decimal  "tax_amount",             default: "0.0"
    t.string   "curr",       limit: 3
    t.string   "doc_type"
    t.string   "status",     limit: 20,  default: "draft"
    t.text     "notes"
    t.integer  "branch_id",                                null: false
    t.integer  "user_id",                                  null: false
    t.integer  "patron_id",                                null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["branch_id"], name: "index_financor_proctaxes_on_branch_id", using: :btree
    t.index ["patron_id"], name: "index_financor_proctaxes_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_proctaxes_on_user_id", using: :btree
  end

  create_table "financor_profit_centers", force: :cascade do |t|
    t.string   "code",        limit: 50
    t.string   "name",        limit: 255
    t.integer  "fiscal_year"
    t.string   "parent_code", limit: 50
    t.string   "status",      limit: 10,  default: "active"
    t.integer  "level",                   default: 1
    t.boolean  "ledgerable",              default: false
    t.text     "notes"
    t.integer  "parent_id"
    t.integer  "patron_id",                                  null: false
    t.integer  "user_id",                                    null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_default",              default: false
    t.index ["code"], name: "index_financor_profit_centers_on_code", using: :btree
    t.index ["parent_id"], name: "index_financor_profit_centers_on_parent_id", using: :btree
    t.index ["patron_id"], name: "index_financor_profit_centers_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_profit_centers_on_user_id", using: :btree
  end

  create_table "financor_schedules", force: :cascade do |t|
    t.date     "action_date"
    t.boolean  "cash_status",           default: true
    t.boolean  "invoice_status",        default: true
    t.boolean  "ledger_status",         default: true
    t.boolean  "payment_status",        default: true
    t.integer  "patron_id",                            null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "credit_invoice_status", default: true
    t.index ["patron_id"], name: "index_financor_schedules_on_patron_id", using: :btree
  end

  create_table "financor_taxcodes", force: :cascade do |t|
    t.string   "name",       limit: 40,                    null: false
    t.decimal  "rate",                  default: "0.0"
    t.string   "code",       limit: 40,                    null: false
    t.integer  "patron_id",                                null: false
    t.integer  "user_id",                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                default: "active"
    t.index ["patron_id"], name: "index_financor_taxcodes_on_patron_id", using: :btree
  end

  create_table "financor_transfins", force: :cascade do |t|
    t.integer "patron_id"
    t.integer "user_id"
    t.string  "parent_type",                                   null: false
    t.integer "parent_id",                                     null: false
    t.string  "status",           limit: 20
    t.string  "status_code",      limit: 20
    t.string  "notes",            limit: 1000
    t.integer "invoice_id"
    t.decimal "estimated_debit",               default: "0.0", null: false
    t.decimal "estimated_credit",              default: "0.0", null: false
    t.decimal "invoiced_debit",                default: "0.0", null: false
    t.decimal "invoiced_credit",               default: "0.0", null: false
    t.string  "curr",             limit: 3
    t.index ["parent_type", "parent_id"], name: "index_financor_transfins_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id", "parent_type", "parent_id"], name: "unique_parent_for_patron", unique: true, using: :btree
    t.index ["patron_id"], name: "index_financor_transfins_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_financor_transfins_on_user_id", using: :btree
  end

  create_table "fleet_customs_expenses", force: :cascade do |t|
    t.integer  "expense_form_id"
    t.integer  "vehicle_id"
    t.integer  "position_id"
    t.integer  "involine_id"
    t.decimal  "amount"
    t.string   "curr",            limit: 3
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "vehicle_code"
    t.text     "notes"
  end

  create_table "fleet_drivers", force: :cascade do |t|
    t.string   "name",            limit: 100,                    null: false
    t.string   "email",           limit: 100
    t.string   "gsm",             limit: 20
    t.string   "phone_os",        limit: 20
    t.string   "tel",             limit: 20
    t.string   "work_type",       limit: 40
    t.integer  "company_id"
    t.string   "address",         limit: 300
    t.string   "city_name",       limit: 30
    t.string   "country_id",      limit: 2
    t.string   "status",          limit: 10,  default: "active"
    t.integer  "patron_id",                                      null: false
    t.string   "avatar",          limit: 255
    t.string   "skype",           limit: 40
    t.string   "twitter",         limit: 40
    t.string   "facebook",        limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "documents_count",             default: 0
    t.integer  "person_id"
    t.integer  "user_id"
    t.integer  "operation_id"
    t.string   "refno",           limit: 30
    t.integer  "truck_id"
    t.text     "notes"
    t.date     "birth_date"
    t.integer  "birth_place_id"
    t.string   "passport"
    t.integer  "branch_id"
    t.integer  "city_id"
    t.string   "remote_id",       limit: 50
    t.index ["branch_id"], name: "index_fleet_drivers_on_branch_id", using: :btree
    t.index ["patron_id"], name: "index_fleet_drivers_on_patron_id", using: :btree
    t.index ["truck_id"], name: "index_fleet_drivers_on_truck_id", using: :btree
  end

  create_table "fleet_drivers_stats_reports", force: :cascade do |t|
    t.string   "driver_id"
    t.integer  "total_work_order",      default: 0
    t.decimal  "total_advance_payment", default: "0.0"
    t.decimal  "total_subsistence",     default: "0.0"
    t.integer  "used_permission",       default: 0
    t.integer  "remaining_permission",  default: 0
    t.integer  "open_account_count",    default: 0
    t.decimal  "total_expense",         default: "0.0"
    t.decimal  "total_cut",             default: "0.0"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "fleet_expense_forms", force: :cascade do |t|
    t.string   "reference",          limit: 30,                    null: false
    t.decimal  "total_amount",                  default: "0.0"
    t.string   "curr",               limit: 10
    t.date     "form_date"
    t.decimal  "balance",                       default: "0.0"
    t.string   "status",             limit: 10, default: "active", null: false
    t.integer  "comments_count",                default: 0
    t.text     "notes"
    t.date     "start_date"
    t.date     "finish_date"
    t.integer  "start_km",                      default: 0
    t.integer  "finish_km",                     default: 0
    t.integer  "agreement_id"
    t.integer  "driver_id"
    t.integer  "person_id"
    t.integer  "patron_id",                                        null: false
    t.integer  "user_id",                                          null: false
    t.integer  "branch_id",                                        null: false
    t.integer  "approver_id"
    t.integer  "route_id"
    t.decimal  "initial_fuel_liter",            default: "0.0"
    t.decimal  "depot_liter",                   default: "0.0"
    t.string   "tariff_type"
    t.decimal  "trip_data_km",                  default: "0.0"
    t.integer  "vehicle_id"
    t.integer  "trailer_id"
    t.integer  "just_trailer_km",               default: 0
    t.integer  "empty_vehicle_km",              default: 0
    t.integer  "full_vehicle_km",               default: 0
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.decimal  "fuel_rate",                     default: "0.0"
    t.decimal  "fuel_consumed",                 default: "0.0"
    t.integer  "voyage_id"
    t.string   "export_import",      limit: 20
    t.integer  "operation_id"
    t.decimal  "exportwg"
    t.decimal  "importwg"
    t.boolean  "trashed",                       default: false
    t.index ["agreement_id"], name: "index_fleet_expense_forms_on_agreement_id", using: :btree
    t.index ["branch_id"], name: "index_fleet_expense_forms_on_branch_id", using: :btree
    t.index ["driver_id"], name: "index_fleet_expense_forms_on_driver_id", using: :btree
    t.index ["operation_id"], name: "index_fleet_expense_forms_on_operation_id", using: :btree
    t.index ["patron_id"], name: "index_fleet_expense_forms_on_patron_id", using: :btree
    t.index ["person_id"], name: "index_fleet_expense_forms_on_person_id", using: :btree
    t.index ["user_id"], name: "index_fleet_expense_forms_on_user_id", using: :btree
    t.index ["voyage_id"], name: "index_fleet_expense_forms_on_voyage_id", using: :btree
  end

  create_table "fleet_fuel_prices", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "user_id",                              null: false
    t.date     "fuel_date",                            null: false
    t.string   "fuel_type",  limit: 8
    t.decimal  "price",                default: "0.0"
    t.string   "price_curr", limit: 3
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "fleet_fuellog_lines", force: :cascade do |t|
    t.integer  "fuellog_id",                    null: false
    t.integer  "warehouse_id"
    t.integer  "vehicle_id"
    t.float    "debit_fuel",      default: 0.0
    t.float    "credit_fuel",     default: 0.0
    t.integer  "odemeter",        default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "expense_form_id"
    t.integer  "driver_id"
    t.index ["expense_form_id"], name: "index_fleet_fuellog_lines_on_expense_form_id", using: :btree
    t.index ["fuellog_id"], name: "index_fleet_fuellog_lines_on_fuellog_id", using: :btree
    t.index ["vehicle_id"], name: "index_fleet_fuellog_lines_on_vehicle_id", using: :btree
    t.index ["warehouse_id"], name: "index_fleet_fuellog_lines_on_warehouse_id", using: :btree
  end

  create_table "fleet_fuellogs", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.date     "fuel_date",                                                null: false
    t.decimal  "fuel_liter",                            default: "0.0",    null: false
    t.decimal  "price",                                 default: "0.0"
    t.string   "price_curr",                limit: 3
    t.integer  "odemeter",                              default: 0
    t.string   "fuel_type"
    t.string   "driver_name",               limit: 30
    t.integer  "vendor_id"
    t.string   "reference",                 limit: 30
    t.string   "notes",                     limit: 500
    t.integer  "patron_id",                                                null: false
    t.integer  "user_id",                                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "depot_liter",                           default: 0.0
    t.integer  "prev_odemeter",                         default: 0
    t.float    "prev_depot_liter",                      default: 0.0
    t.float    "fuel_rate",                             default: 0.0
    t.boolean  "validate_fuel",                         default: false
    t.boolean  "depot_filled",                          default: false
    t.float    "adblue_liter",                          default: 0.0
    t.integer  "driver_id"
    t.integer  "agreement_id"
    t.integer  "expense_form_id"
    t.integer  "warehouse_id"
    t.string   "doc_no",                    limit: 25
    t.date     "doc_date"
    t.integer  "trailer_id"
    t.integer  "trailer_liter",                         default: 0
    t.integer  "transfer_vehicle_id"
    t.integer  "transfer_driver_id"
    t.integer  "transfer_vehicle_odemeter",             default: 0
    t.string   "action_type",               limit: 10
    t.boolean  "trashed",                               default: false
    t.integer  "involine_id"
    t.string   "vendor_type",               limit: 30
    t.string   "country_id",                limit: 2
    t.integer  "person_id"
    t.string   "person_type",               limit: 30
    t.string   "card_no",                   limit: 70
    t.string   "station"
    t.integer  "approver_id"
    t.datetime "approval_date"
    t.string   "status",                    limit: 40,  default: "active"
    t.index ["expense_form_id"], name: "index_fleet_fuellogs_on_expense_form_id", using: :btree
    t.index ["patron_id"], name: "index_fleet_fuellogs_on_patron_id", using: :btree
    t.index ["trailer_id"], name: "index_fleet_fuellogs_on_trailer_id", using: :btree
    t.index ["transfer_driver_id"], name: "index_fleet_fuellogs_on_transfer_driver_id", using: :btree
    t.index ["transfer_vehicle_id"], name: "index_fleet_fuellogs_on_transfer_vehicle_id", using: :btree
    t.index ["vehicle_id"], name: "index_fleet_fuellogs_on_vehicle_id", using: :btree
    t.index ["vendor_id"], name: "index_fleet_fuellogs_on_vendor_id", using: :btree
    t.index ["warehouse_id"], name: "index_fleet_fuellogs_on_warehouse_id", using: :btree
  end

  create_table "fleet_gate_action_status", force: :cascade do |t|
    t.integer  "gate_action_id",             null: false
    t.integer  "user_id",                    null: false
    t.string   "status",         limit: 20
    t.string   "notes",          limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["gate_action_id"], name: "index_fleet_gate_action_status_on_gate_action_id", using: :btree
    t.index ["user_id"], name: "index_fleet_gate_action_status_on_user_id", using: :btree
  end

  create_table "fleet_gate_actions", force: :cascade do |t|
    t.integer  "place_id"
    t.integer  "vehicle_id"
    t.integer  "trailer_id"
    t.integer  "driver_id"
    t.integer  "patron_id",                                     null: false
    t.integer  "user_id",                                       null: false
    t.string   "alias_method"
    t.string   "actor_type"
    t.string   "action_type"
    t.string   "vehicle_name",      limit: 20
    t.string   "trailer_name",      limit: 20
    t.string   "driver_name",       limit: 50
    t.string   "driver_tckn",       limit: 20
    t.string   "company_name",      limit: 60
    t.string   "target_name",       limit: 255
    t.string   "notes",             limit: 255
    t.datetime "action_date"
    t.integer  "vehicle_odemeter"
    t.integer  "previous_odemeter"
    t.integer  "output_action_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "load_status",       limit: 20
    t.string   "container_no",      limit: 50
    t.string   "seal_no",           limit: 50
    t.string   "status",            limit: 20
    t.boolean  "trashed",                       default: false
    t.string   "card_no",           limit: 50
    t.string   "from_where",        limit: 60
    t.index ["driver_id"], name: "index_fleet_gate_actions_on_driver_id", using: :btree
    t.index ["patron_id"], name: "index_fleet_gate_actions_on_patron_id", using: :btree
    t.index ["place_id"], name: "index_fleet_gate_actions_on_place_id", using: :btree
    t.index ["trailer_id"], name: "index_fleet_gate_actions_on_trailer_id", using: :btree
    t.index ["user_id"], name: "index_fleet_gate_actions_on_user_id", using: :btree
    t.index ["vehicle_id"], name: "index_fleet_gate_actions_on_vehicle_id", using: :btree
  end

  create_table "fleet_gpsservice_responses", force: :cascade do |t|
    t.integer  "gpsservice_id",                                null: false
    t.string   "identity",             limit: 100,             null: false
    t.float    "longitude"
    t.float    "latitude"
    t.string   "direction",            limit: 100
    t.integer  "odometer",                         default: 0
    t.string   "geo_address",          limit: 255
    t.string   "geo_country",          limit: 50
    t.string   "postal_code",          limit: 10
    t.integer  "temp_speed",                       default: 0
    t.integer  "canbus_odometer",                  default: 0
    t.string   "vehicle_ignition",     limit: 255
    t.datetime "last_connection_date"
    t.integer  "patron_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint   "eventlogid"
    t.index ["gpsservice_id"], name: "index_fleet_gpsservice_responses_on_gpsservice_id", using: :btree
  end

  create_table "fleet_gpsservices", force: :cascade do |t|
    t.string   "code",       limit: 30
    t.string   "uid",        limit: 255
    t.string   "passwd",     limit: 255
    t.string   "status",     limit: 10,  default: "active"
    t.integer  "patron_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",      limit: 255
    t.index ["patron_id"], name: "index_fleet_gpsservices_on_patron_id", using: :btree
  end

  create_table "fleet_part_locations", force: :cascade do |t|
    t.string   "name"
    t.string   "status",     default: "active"
    t.text     "notes"
    t.integer  "branch_id",                     null: false
    t.integer  "patron_id",                     null: false
    t.integer  "user_id",                       null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "manager_id"
    t.index ["branch_id"], name: "index_fleet_part_locations_on_branch_id", using: :btree
    t.index ["patron_id"], name: "index_fleet_part_locations_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_fleet_part_locations_on_user_id", using: :btree
  end

  create_table "fleet_part_stocklines", force: :cascade do |t|
    t.integer  "part_stock_id"
    t.integer  "part_location_id"
    t.integer  "part_id"
    t.integer  "debit"
    t.integer  "credit"
    t.integer  "debit_vehicle_id"
    t.integer  "debit_driver_id"
    t.integer  "credit_vehicle_id"
    t.integer  "credit_driver_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "credit_part_location_id"
    t.index ["credit_driver_id"], name: "index_fleet_part_stocklines_on_credit_driver_id", using: :btree
    t.index ["credit_vehicle_id"], name: "index_fleet_part_stocklines_on_credit_vehicle_id", using: :btree
    t.index ["debit_driver_id"], name: "index_fleet_part_stocklines_on_debit_driver_id", using: :btree
    t.index ["debit_vehicle_id"], name: "index_fleet_part_stocklines_on_debit_vehicle_id", using: :btree
    t.index ["part_id"], name: "index_fleet_part_stocklines_on_part_id", using: :btree
    t.index ["part_location_id"], name: "index_fleet_part_stocklines_on_part_location_id", using: :btree
    t.index ["part_stock_id"], name: "index_fleet_part_stocklines_on_part_stock_id", using: :btree
  end

  create_table "fleet_part_stocks", force: :cascade do |t|
    t.string   "reference"
    t.string   "doc_type"
    t.date     "doc_date"
    t.integer  "branch_id",               null: false
    t.integer  "patron_id",               null: false
    t.integer  "user_id",                 null: false
    t.integer  "part_stock_id"
    t.integer  "part_location_id"
    t.integer  "part_id"
    t.integer  "count"
    t.integer  "debit"
    t.integer  "credit"
    t.integer  "debit_vehicle_id"
    t.integer  "debit_driver_id"
    t.integer  "credit_vehicle_id"
    t.integer  "credit_driver_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "credit_part_location_id"
    t.text     "notes"
    t.index ["branch_id"], name: "index_fleet_part_stocks_on_branch_id", using: :btree
    t.index ["credit_driver_id"], name: "index_fleet_part_stocks_on_credit_driver_id", using: :btree
    t.index ["credit_vehicle_id"], name: "index_fleet_part_stocks_on_credit_vehicle_id", using: :btree
    t.index ["debit_driver_id"], name: "index_fleet_part_stocks_on_debit_driver_id", using: :btree
    t.index ["debit_vehicle_id"], name: "index_fleet_part_stocks_on_debit_vehicle_id", using: :btree
    t.index ["part_id"], name: "index_fleet_part_stocks_on_part_id", using: :btree
    t.index ["part_location_id"], name: "index_fleet_part_stocks_on_part_location_id", using: :btree
    t.index ["part_stock_id"], name: "index_fleet_part_stocks_on_part_stock_id", using: :btree
    t.index ["patron_id"], name: "index_fleet_part_stocks_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_fleet_part_stocks_on_user_id", using: :btree
  end

  create_table "fleet_parts", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.string   "unit_type"
    t.string   "status",     default: "active"
    t.text     "notes"
    t.integer  "patron_id",                     null: false
    t.integer  "user_id",                       null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "finitem_id"
    t.index ["patron_id"], name: "index_fleet_parts_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_fleet_parts_on_user_id", using: :btree
  end

  create_table "fleet_periodoc_types", force: :cascade do |t|
    t.string   "name",       limit: 50
    t.string   "category",   limit: 20
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "patron_id",             null: false
    t.integer  "user_id",               null: false
    t.string   "name_en",    limit: 50
    t.index ["patron_id"], name: "index_fleet_periodoc_types_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_fleet_periodoc_types_on_user_id", using: :btree
  end

  create_table "fleet_periodocs", force: :cascade do |t|
    t.string   "title",            limit: 100,                    null: false
    t.string   "doc_type",         limit: 30
    t.date     "due_date",                                        null: false
    t.string   "doc_no",           limit: 20
    t.date     "doc_date"
    t.integer  "vehicle_id"
    t.integer  "driver_id"
    t.text     "notes"
    t.integer  "patron_id",                                       null: false
    t.integer  "user_id",                                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "trashed",                      default: false
    t.integer  "periodoc_type_id"
    t.integer  "ledger_id"
    t.date     "ledger_date"
    t.integer  "company_id"
    t.integer  "branch_id"
    t.decimal  "amount",                       default: "0.0"
    t.string   "curr",             limit: 3
    t.decimal  "curr_rate",                    default: "0.0"
    t.integer  "vat_id"
    t.decimal  "vat_amount",                   default: "0.0"
    t.decimal  "total_amount",                 default: "0.0"
    t.text     "cancel_note"
    t.decimal  "cancel_price",                 default: "0.0"
    t.string   "status",                       default: "active"
    t.integer  "pay_term_id"
    t.date     "start_date"
    t.integer  "operation_id"
    t.date     "cancel_date"
    t.index ["branch_id"], name: "index_fleet_periodocs_on_branch_id", using: :btree
    t.index ["company_id"], name: "index_fleet_periodocs_on_company_id", using: :btree
    t.index ["driver_id"], name: "index_fleet_periodocs_on_personal_id", using: :btree
    t.index ["ledger_id"], name: "index_fleet_periodocs_on_ledger_id", using: :btree
    t.index ["operation_id"], name: "index_fleet_periodocs_on_operation_id", using: :btree
    t.index ["patron_id"], name: "index_fleet_periodocs_on_patron_id", using: :btree
    t.index ["pay_term_id"], name: "index_fleet_periodocs_on_pay_term_id", using: :btree
    t.index ["periodoc_type_id"], name: "index_fleet_periodocs_on_periodoc_type_id", using: :btree
    t.index ["vat_id"], name: "index_fleet_periodocs_on_vat_id", using: :btree
    t.index ["vehicle_id"], name: "index_fleet_periodocs_on_vehicle_id", using: :btree
  end

  create_table "fleet_serviceloglines", force: :cascade do |t|
    t.integer  "servicelog_id",               null: false
    t.integer  "part_id",                     null: false
    t.float    "quantity",      default: 0.0
    t.float    "total_price",   default: 0.0
    t.float    "discount_rate", default: 0.0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["part_id"], name: "index_fleet_serviceloglines_on_part_id", using: :btree
    t.index ["servicelog_id"], name: "index_fleet_serviceloglines_on_servicelog_id", using: :btree
  end

  create_table "fleet_servicelogs", force: :cascade do |t|
    t.integer  "vehicle_id",                               null: false
    t.date     "service_date",                             null: false
    t.integer  "odemeter",                 default: 0
    t.decimal  "price",                    default: "0.0"
    t.string   "price_curr",    limit: 3
    t.integer  "vendor_id"
    t.string   "reference",     limit: 50
    t.text     "changed_parts"
    t.text     "notes"
    t.integer  "user_id",                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "patron_id",                                null: false
    t.integer  "operation_id"
    t.integer  "invoice_id"
    t.text     "invoice_notes"
    t.decimal  "usd_rate",                 default: "1.0"
    t.decimal  "eur_rate",                 default: "1.0"
    t.decimal  "curr_rate",                default: "1.0"
    t.index ["patron_id"], name: "index_fleet_servicelogs_on_patron_id", using: :btree
  end

  create_table "fleet_tarifflines", force: :cascade do |t|
    t.integer  "tariff_id",                            null: false
    t.integer  "finitem_id"
    t.string   "cunit1"
    t.string   "cunit2"
    t.decimal  "rate",                 default: "0.0"
    t.integer  "start_day"
    t.integer  "finish_day"
    t.decimal  "min_price",            default: "0.0"
    t.string   "curr",       limit: 3
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["finitem_id"], name: "index_fleet_tarifflines_on_finitem_id", using: :btree
    t.index ["tariff_id"], name: "index_fleet_tarifflines_on_tariff_id", using: :btree
  end

  create_table "fleet_tariffs", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.date     "due_date"
    t.decimal  "min_price"
    t.string   "curr",          limit: 3
    t.string   "status",        limit: 20
    t.string   "vehicle_class", limit: 30
    t.string   "vehicle_type",  limit: 30
    t.integer  "company_id"
    t.integer  "vehicle_id"
    t.integer  "user_id"
    t.integer  "patron_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["company_id"], name: "index_fleet_tariffs_on_company_id", using: :btree
    t.index ["patron_id"], name: "index_fleet_tariffs_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_fleet_tariffs_on_user_id", using: :btree
    t.index ["vehicle_id"], name: "index_fleet_tariffs_on_vehicle_id", using: :btree
  end

  create_table "fleet_transdoclines", force: :cascade do |t|
    t.integer  "transdoc_id"
    t.string   "vehicle_code"
    t.integer  "vehicle_id"
    t.integer  "position_id"
    t.string   "voyage_no"
    t.date     "voyage_date"
    t.string   "voyage_vessel"
    t.string   "truck_code"
    t.integer  "truck_id"
    t.text     "notes"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "line_number"
    t.integer  "dep_place_id"
    t.integer  "arv_place_id"
    t.decimal  "additional_price"
    t.string   "additional_price_curr", limit: 3
    t.string   "direction",             limit: 10, default: "some"
    t.string   "round_trip",            limit: 10
    t.index ["position_id"], name: "index_fleet_transdoclines_on_position_id", using: :btree
    t.index ["transdoc_id"], name: "index_fleet_transdoclines_on_transdoc_id", using: :btree
    t.index ["vehicle_id"], name: "index_fleet_transdoclines_on_vehicle_id", using: :btree
  end

  create_table "fleet_transdocs", force: :cascade do |t|
    t.datetime "ticket_date"
    t.datetime "due_date"
    t.string   "ticket_no"
    t.string   "ticket_type"
    t.integer  "company_id"
    t.integer  "dep_place_id"
    t.integer  "arv_place_id"
    t.integer  "supplier_id"
    t.decimal  "amount"
    t.string   "curr"
    t.string   "invoice_no"
    t.integer  "invoice_id"
    t.string   "promotion_type"
    t.text     "notes"
    t.integer  "pages_count"
    t.integer  "used_pages_count"
    t.integer  "user_id"
    t.integer  "patron_id"
    t.integer  "comments_count"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "transdoc_type",    limit: 50
    t.integer  "going_truck_id"
    t.integer  "turn_truck_id"
    t.index ["patron_id"], name: "index_fleet_transdocs_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_fleet_transdocs_on_user_id", using: :btree
  end

  create_table "fleet_vehicle_actions", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.string   "vehicle_name", limit: 30, null: false
    t.string   "action_type",  limit: 20, null: false
    t.datetime "action_date",             null: false
    t.integer  "place_id",                null: false
    t.integer  "driver_id"
    t.string   "driver_name",  limit: 50
    t.string   "vehicle2",     limit: 30
    t.string   "vehicle3",     limit: 30
    t.text     "notes"
    t.integer  "user_id",                 null: false
    t.integer  "patron_id",               null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["action_date"], name: "index_fleet_vehicle_actions_on_action_date", using: :btree
    t.index ["action_type"], name: "index_fleet_vehicle_actions_on_action_type", using: :btree
    t.index ["patron_id"], name: "index_fleet_vehicle_actions_on_patron_id", using: :btree
    t.index ["place_id"], name: "index_fleet_vehicle_actions_on_place_id", using: :btree
    t.index ["vehicle_id"], name: "index_fleet_vehicle_actions_on_vehicle_id", using: :btree
  end

  create_table "fleet_vehicle_types", force: :cascade do |t|
    t.string   "name",       limit: 50
    t.string   "category",   limit: 2
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "fleet_vehicles", force: :cascade do |t|
    t.string   "name",                       limit: 255,                    null: false
    t.string   "code",                       limit: 20,                     null: false
    t.string   "vehicle_class",              limit: 20
    t.string   "vehicle_type",               limit: 20
    t.string   "brand",                      limit: 20
    t.string   "model",                      limit: 50
    t.integer  "model_year"
    t.integer  "patron_id"
    t.string   "owner",                      limit: 50
    t.decimal  "vehicle_price",                          default: "0.0"
    t.string   "price_curr",                 limit: 5
    t.date     "buying_date"
    t.integer  "fuel_capacity"
    t.string   "fuel_type",                  limit: 10
    t.string   "tire_size",                  limit: 20
    t.string   "link_type",                  limit: 2
    t.float    "longitude"
    t.float    "latitude"
    t.string   "slug",                       limit: 20
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "documents_count"
    t.integer  "todolists_count"
    t.integer  "discussions_count"
    t.integer  "fuelentries_count"
    t.integer  "servicelogs_count"
    t.integer  "odemeters_count"
    t.integer  "odometer",                               default: 0
    t.decimal  "depot_liter",                            default: "0.0"
    t.date     "fuel_date"
    t.integer  "fuel_odemeter",                          default: 0
    t.float    "fuel_rate",                              default: 0.0
    t.integer  "fuellog_id"
    t.string   "fuel_unit",                  limit: 10,  default: "liter"
    t.string   "speed_unit",                 limit: 10,  default: "km"
    t.string   "color",                      limit: 20
    t.string   "vehicle_status",             limit: 15,  default: "active"
    t.string   "registered_to",              limit: 30
    t.float    "default_fuel_rate",                      default: 0.0
    t.string   "owner_type",                 limit: 10
    t.integer  "company_id"
    t.boolean  "validate_fuel",                          default: false
    t.float    "weight",                                 default: 0.0
    t.string   "weight_unit"
    t.integer  "last_place_id"
    t.string   "last_place",                 limit: 255
    t.string   "last_city_name",             limit: 60
    t.string   "last_country_id",            limit: 2
    t.integer  "driver_id"
    t.string   "country_id",                 limit: 2
    t.integer  "covehicle_id"
    t.string   "dom_int",                    limit: 10
    t.string   "license_number",             limit: 100
    t.string   "license_place",              limit: 100
    t.string   "chassis_number",             limit: 100
    t.string   "engine_number",              limit: 100
    t.string   "registration_number",        limit: 100
    t.date     "registration_date"
    t.float    "netwg"
    t.integer  "hourse_power"
    t.integer  "axle_count"
    t.string   "components",                 limit: 255
    t.integer  "tariff_id"
    t.integer  "user_id"
    t.integer  "branch_id"
    t.decimal  "volume",                                 default: "0.0"
    t.decimal  "tonaj",                                  default: "0.0"
    t.decimal  "rent_amount"
    t.string   "rent_amount_curr",           limit: 20
    t.integer  "odemeter_limit"
    t.date     "rent_start_date"
    t.date     "rent_finish_date"
    t.integer  "person_id"
    t.integer  "operation_id"
    t.integer  "planned_position_id"
    t.integer  "active_position_id"
    t.integer  "dimension1"
    t.integer  "dimension2"
    t.integer  "dimension3"
    t.string   "tailboard"
    t.string   "roof"
    t.integer  "auto_tonaj"
    t.datetime "last_gps_time"
    t.integer  "info_place_id"
    t.integer  "fuel_limit"
    t.string   "blocked_note"
    t.integer  "last_city_id"
    t.integer  "last_delivered_position_id"
    t.date     "last_deliver_date"
    t.date     "enter_dep_customs_date"
    t.date     "exit_dep_customs_date"
    t.date     "enter_arv_customs_date"
    t.date     "exit_arv_customs_date"
    t.decimal  "tire_inc",                               default: "0.0"
    t.decimal  "tire_height",                            default: "0.0"
    t.string   "gps_vehicle_id",             limit: 50
    t.integer  "profit_center_id"
    t.string   "remote_id",                  limit: 50
    t.integer  "operator_id"
    t.integer  "approver_id"
    t.date     "approved_at"
    t.index ["branch_id"], name: "index_fleet_vehicles_on_branch_id", using: :btree
    t.index ["code", "patron_id"], name: "index_fleet_vehicles_on_code_and_patron_id", unique: true, using: :btree
    t.index ["patron_id"], name: "index_fleet_vehicles_on_patron_id", using: :btree
    t.index ["tariff_id"], name: "index_fleet_vehicles_on_tariff_id", using: :btree
    t.index ["user_id"], name: "index_fleet_vehicles_on_user_id", using: :btree
  end

  create_table "fleet_vehicles_stats_reports", force: :cascade do |t|
    t.string   "vehicle_id"
    t.integer  "total_km",            default: 0
    t.integer  "total_work_order",    default: 0
    t.integer  "total_fuel",          default: 0
    t.integer  "total_service_count", default: 0
    t.decimal  "total_service_price", default: "0.0"
    t.decimal  "total_invoice_price", default: "0.0"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "helpdesk_feedbacks", force: :cascade do |t|
    t.string   "name",       limit: 40,  null: false
    t.string   "email",      limit: 100
    t.string   "msg",        limit: 500
    t.integer  "user_id"
    t.integer  "patron_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "helpdesk_project_users", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.index ["project_id"], name: "index_helpdesk_project_users_on_project_id", using: :btree
    t.index ["user_id"], name: "index_helpdesk_project_users_on_user_id", using: :btree
  end

  create_table "helpdesk_projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "patron_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
    t.integer  "user_id"
  end

  create_table "helpdesk_teams", force: :cascade do |t|
    t.string   "title",      limit: 100, null: false
    t.string   "email",      limit: 30
    t.integer  "patron_id",              null: false
    t.integer  "user_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["patron_id"], name: "index_helpdesk_teams_on_patron_id", using: :btree
  end

  create_table "helpdesk_ticket_actions", force: :cascade do |t|
    t.integer  "ticket_id",               null: false
    t.integer  "user_id",                 null: false
    t.string   "action_code", limit: 30,  null: false
    t.string   "assigned",    limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ticket_id"], name: "index_helpdesk_ticket_actions_on_ticket_id", using: :btree
  end

  create_table "helpdesk_tickets", force: :cascade do |t|
    t.string   "title",           limit: 255,                 null: false
    t.text     "desc",                                        null: false
    t.integer  "user_id"
    t.integer  "patron_id",                                   null: false
    t.string   "status",          limit: 30,                  null: false
    t.integer  "assigned_id"
    t.date     "close_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reference",       limit: 30
    t.integer  "team_id"
    t.integer  "documents_count",             default: 0
    t.string   "owner_name",      limit: 100
    t.string   "owner_email",     limit: 100
    t.integer  "update_user_id"
    t.boolean  "trashed",                     default: false
    t.date     "deadline"
    t.index ["patron_id"], name: "index_helpdesk_tickets_on_patron_id", using: :btree
    t.index ["team_id"], name: "index_helpdesk_tickets_on_team_id", using: :btree
    t.index ["user_id"], name: "index_helpdesk_tickets_on_user_id", using: :btree
  end

  create_table "helpdesk_todos", force: :cascade do |t|
    t.string   "todo_text",                                       null: false
    t.date     "due_date"
    t.date     "closed_date"
    t.string   "close_text",      limit: 255
    t.boolean  "system_task",                 default: false
    t.integer  "patron_id"
    t.integer  "user_id"
    t.integer  "assigned_id"
    t.integer  "comments_count",              default: 0
    t.string   "color"
    t.integer  "project_id"
    t.string   "img_data"
    t.string   "status",          limit: 10,  default: "pending"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "owner_id"
    t.string   "parent_type",     limit: 100
    t.integer  "parent_id"
    t.integer  "group_id"
    t.integer  "closer_id"
    t.integer  "parent_todo_id"
    t.string   "cancel_text",     limit: 255
    t.string   "suspend_text",    limit: 255
    t.string   "tech_close_code", limit: 255
    t.string   "tech_close_text", limit: 255
    t.boolean  "trashed",                     default: false
  end

  create_table "hr_agiparams", force: :cascade do |t|
    t.integer "sgkparam_id",                    null: false
    t.string  "medeni_durum"
    t.boolean "es_calisiyor",   default: false
    t.integer "cocuk_sayisi",   default: 0
    t.decimal "indirim_tutari"
    t.decimal "oran",           default: "0.0"
    t.index ["sgkparam_id"], name: "index_hr_agiparams_on_sgkparam_id", using: :btree
  end

  create_table "hr_assistlines", force: :cascade do |t|
    t.integer "assist_id",                                         null: false
    t.string  "tckn"
    t.string  "name"
    t.string  "surname"
    t.string  "first_surname"
    t.decimal "salary",                          default: "0.0"
    t.decimal "premium",                         default: "0.0"
    t.integer "day",                             default: 0
    t.integer "missing_day",                     default: 0
    t.date    "hire_date"
    t.date    "fire_date"
    t.string  "fire_cause"
    t.string  "missing_day_cause"
    t.string  "job_code"
    t.string  "status",                          default: "draft"
    t.date    "incentive_start_date"
    t.date    "incentive_finish_date"
    t.integer "employee_average"
    t.decimal "incentive_10",                    default: "0.0"
    t.decimal "incentive_15",                    default: "0.0"
    t.decimal "incentive_19",                    default: "0.0"
    t.decimal "incentive_20",                    default: "0.0"
    t.decimal "incentive_28",                    default: "0.0"
    t.string  "incentive_law_code"
    t.decimal "incentive_law_amount",            default: "0.0"
    t.integer "rejected_id"
    t.string  "registration_number"
    t.date    "first_declaration_date"
    t.date    "sgk_start_date"
    t.date    "sgk_finish_date"
    t.string  "report_no"
    t.decimal "disabled_rate",                   default: "0.0"
    t.string  "law_first"
    t.string  "law_second"
    t.string  "law_third"
    t.string  "law_fourth"
    t.string  "lack_cause"
    t.date    "hire_doc_date"
    t.text    "notes"
    t.integer "previous_assist_id"
    t.string  "law_declared"
    t.string  "law_used"
    t.decimal "law_used_amount",                 default: "0.0"
    t.decimal "law_amount_first",                default: "0.0"
    t.decimal "law_amount_second",               default: "0.0"
    t.decimal "law_amount_third",                default: "0.0"
    t.decimal "law_amount_fourth",               default: "0.0"
    t.decimal "law_used_amount_first",           default: "0.0"
    t.decimal "law_used_amount_second",          default: "0.0"
    t.decimal "law_used_amount_third",           default: "0.0"
    t.decimal "law_used_amount_fourth",          default: "0.0"
    t.string  "salary_support"
    t.date    "salary_support_start_date"
    t.date    "salary_support_finish_date"
    t.integer "salary_support_additional_count", default: 0
    t.index ["assist_id"], name: "index_hr_assistlines_on_assist_id", using: :btree
    t.index ["previous_assist_id"], name: "index_hr_assistlines_on_previous_assist_id", using: :btree
  end

  create_table "hr_assists", force: :cascade do |t|
    t.integer "office_id",                       null: false
    t.integer "patron_id",                       null: false
    t.integer "user_id",                         null: false
    t.string  "doc_content"
    t.string  "doc_type"
    t.integer "assist_year"
    t.integer "assist_month"
    t.string  "law_no"
    t.integer "total_worker"
    t.integer "total_day"
    t.decimal "total_amount"
    t.date    "approval_date"
    t.string  "pdf_status"
    t.integer "activity_year"
    t.integer "activity_month"
    t.string  "assist_ref_no"
    t.integer "edeclaration_id"
    t.string  "incentive_type"
    t.string  "file_path"
    t.integer "personel_count",  default: 0
    t.integer "aphb_count",      default: 0
    t.boolean "pdf_written",     default: false
    t.index ["edeclaration_id"], name: "index_hr_assists_on_edeclaration_id", using: :btree
    t.index ["office_id"], name: "index_hr_assists_on_office_id", using: :btree
    t.index ["patron_id"], name: "index_hr_assists_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_hr_assists_on_user_id", using: :btree
  end

  create_table "hr_behaviors", force: :cascade do |t|
    t.string   "behavior_type", limit: 100
    t.string   "behavior_text"
    t.text     "notes"
    t.string   "status",                    default: "draft"
    t.string   "parent_type",                                 null: false
    t.integer  "parent_id",                                   null: false
    t.integer  "user_id",                                     null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["parent_type", "parent_id"], name: "index_hr_behaviors_on_parent_type_and_parent_id", using: :btree
    t.index ["user_id"], name: "index_hr_behaviors_on_user_id", using: :btree
  end

  create_table "hr_benefits", force: :cascade do |t|
    t.integer  "person_id",                                      null: false
    t.string   "benefit_type",     limit: 20
    t.string   "period",           limit: 10
    t.decimal  "amount"
    t.string   "curr",             limit: 3
    t.string   "unit",             limit: 10
    t.boolean  "monetary",                    default: true
    t.string   "brut_net",         limit: 10
    t.string   "status",           limit: 10, default: "active"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "workday_param_id"
    t.boolean  "affect_payroll",              default: false
    t.text     "notes"
    t.boolean  "month_1",                     default: true
    t.boolean  "month_2",                     default: true
    t.boolean  "month_3",                     default: true
    t.boolean  "month_4",                     default: true
    t.boolean  "month_5",                     default: true
    t.boolean  "month_6",                     default: true
    t.boolean  "month_7",                     default: true
    t.boolean  "month_8",                     default: true
    t.boolean  "month_9",                     default: true
    t.boolean  "month_10",                    default: true
    t.boolean  "month_11",                    default: true
    t.boolean  "month_12",                    default: true
    t.index ["person_id"], name: "index_hr_benefits_on_person_id", using: :btree
    t.index ["workday_param_id"], name: "index_hr_benefits_on_workday_param_id", using: :btree
  end

  create_table "hr_brief_types", force: :cascade do |t|
    t.string  "code"
    t.string  "name"
    t.integer "brut_salary_account_id"
    t.integer "sgk_employee_account_id"
    t.integer "sgdp_employee_account_id"
    t.integer "unemployment_employee_account_id"
    t.integer "net_salary_account_id"
    t.integer "income_tax_account_id"
    t.integer "proc_tax_account_id"
    t.integer "sgk_person_account_id"
    t.integer "sgdp_person_account_id"
    t.integer "unemployment_person_account_id"
    t.integer "bes_account_id"
    t.integer "agi_account_id"
    t.integer "advence_deduction_account_id"
    t.integer "levy_deduction_account_id"
    t.integer "trafik_fine_account_id"
    t.integer "debit_deduction_account_id"
    t.integer "health_insurance_deduction_account_id"
    t.integer "incentive_5510_account_id"
    t.integer "incentive_7103_account_id"
    t.integer "incentive_6111_account_id"
    t.integer "incentive_6661_account_id"
    t.integer "patron_id",                                                null: false
    t.integer "user_id"
    t.text    "notes"
    t.string  "status",                                 default: "draft"
    t.integer "brut_salary_profit_center_id"
    t.integer "sgk_employee_profit_center_id"
    t.integer "sgdp_employee_profit_center_id"
    t.integer "unemployment_employee_profit_center_id"
    t.integer "net_salary_profit_center_id"
    t.integer "income_tax_profit_center_id"
    t.integer "proc_tax_profit_center_id"
    t.integer "sgk_person_profit_center_id"
    t.integer "sgdp_person_profit_center_id"
    t.integer "unemployment_person_profit_center_id"
    t.integer "bes_profit_center_id"
    t.integer "agi_profit_center_id"
    t.integer "advence_deduction_profit_center_id"
    t.integer "levy_deduction_profit_center_id"
    t.integer "trafik_fine_profit_center_id"
    t.integer "debit_deduction_profit_center_id"
    t.integer "h_insurance_deduction_profit_center_id"
    t.integer "incentive_5510_profit_center_id"
    t.integer "incentive_7103_profit_center_id"
    t.integer "incentive_6111_profit_center_id"
    t.integer "incentive_6661_profit_center_id"
    t.integer "incentive_accrual_account_id"
    t.integer "incentive_accrual_profit_center_id"
    t.integer "food_benefit_account_id"
    t.integer "food_benefit_profit_center_id"
    t.integer "road_benefit_account_id"
    t.integer "road_benefit_profit_center_id"
    t.index ["advence_deduction_account_id"], name: "index_hr_brief_types_on_advence_deduction_account_id", using: :btree
    t.index ["advence_deduction_profit_center_id"], name: "index_hr_brief_types_on_advence_deduction_profit_center_id", using: :btree
    t.index ["agi_account_id"], name: "index_hr_brief_types_on_agi_account_id", using: :btree
    t.index ["agi_profit_center_id"], name: "index_hr_brief_types_on_agi_profit_center_id", using: :btree
    t.index ["bes_account_id"], name: "index_hr_brief_types_on_bes_account_id", using: :btree
    t.index ["bes_profit_center_id"], name: "index_hr_brief_types_on_bes_profit_center_id", using: :btree
    t.index ["brut_salary_account_id"], name: "index_hr_brief_types_on_brut_salary_account_id", using: :btree
    t.index ["brut_salary_profit_center_id"], name: "index_hr_brief_types_on_brut_salary_profit_center_id", using: :btree
    t.index ["debit_deduction_account_id"], name: "index_hr_brief_types_on_debit_deduction_account_id", using: :btree
    t.index ["debit_deduction_profit_center_id"], name: "index_hr_brief_types_on_debit_deduction_profit_center_id", using: :btree
    t.index ["food_benefit_account_id"], name: "index_hr_brief_types_on_food_benefit_account_id", using: :btree
    t.index ["food_benefit_profit_center_id"], name: "index_hr_brief_types_on_food_benefit_profit_center_id", using: :btree
    t.index ["h_insurance_deduction_profit_center_id"], name: "index_hr_brief_types_on_h_insurance_deduction_profit_center_id", using: :btree
    t.index ["health_insurance_deduction_account_id"], name: "index_hr_brief_types_on_health_insurance_deduction_account_id", using: :btree
    t.index ["incentive_5510_account_id"], name: "index_hr_brief_types_on_incentive_5510_account_id", using: :btree
    t.index ["incentive_5510_profit_center_id"], name: "index_hr_brief_types_on_incentive_5510_profit_center_id", using: :btree
    t.index ["incentive_6111_account_id"], name: "index_hr_brief_types_on_incentive_6111_account_id", using: :btree
    t.index ["incentive_6111_profit_center_id"], name: "index_hr_brief_types_on_incentive_6111_profit_center_id", using: :btree
    t.index ["incentive_6661_account_id"], name: "index_hr_brief_types_on_incentive_6661_account_id", using: :btree
    t.index ["incentive_6661_profit_center_id"], name: "index_hr_brief_types_on_incentive_6661_profit_center_id", using: :btree
    t.index ["incentive_7103_account_id"], name: "index_hr_brief_types_on_incentive_7103_account_id", using: :btree
    t.index ["incentive_7103_profit_center_id"], name: "index_hr_brief_types_on_incentive_7103_profit_center_id", using: :btree
    t.index ["incentive_accrual_account_id"], name: "index_hr_brief_types_on_incentive_accrual_account_id", using: :btree
    t.index ["incentive_accrual_profit_center_id"], name: "index_hr_brief_types_on_incentive_accrual_profit_center_id", using: :btree
    t.index ["income_tax_account_id"], name: "index_hr_brief_types_on_income_tax_account_id", using: :btree
    t.index ["income_tax_profit_center_id"], name: "index_hr_brief_types_on_income_tax_profit_center_id", using: :btree
    t.index ["levy_deduction_account_id"], name: "index_hr_brief_types_on_levy_deduction_account_id", using: :btree
    t.index ["levy_deduction_profit_center_id"], name: "index_hr_brief_types_on_levy_deduction_profit_center_id", using: :btree
    t.index ["net_salary_account_id"], name: "index_hr_brief_types_on_net_salary_account_id", using: :btree
    t.index ["net_salary_profit_center_id"], name: "index_hr_brief_types_on_net_salary_profit_center_id", using: :btree
    t.index ["patron_id"], name: "index_hr_brief_types_on_patron_id", using: :btree
    t.index ["proc_tax_account_id"], name: "index_hr_brief_types_on_proc_tax_account_id", using: :btree
    t.index ["proc_tax_profit_center_id"], name: "index_hr_brief_types_on_proc_tax_profit_center_id", using: :btree
    t.index ["road_benefit_account_id"], name: "index_hr_brief_types_on_road_benefit_account_id", using: :btree
    t.index ["road_benefit_profit_center_id"], name: "index_hr_brief_types_on_road_benefit_profit_center_id", using: :btree
    t.index ["sgdp_employee_account_id"], name: "index_hr_brief_types_on_sgdp_employee_account_id", using: :btree
    t.index ["sgdp_employee_profit_center_id"], name: "index_hr_brief_types_on_sgdp_employee_profit_center_id", using: :btree
    t.index ["sgdp_person_account_id"], name: "index_hr_brief_types_on_sgdp_person_account_id", using: :btree
    t.index ["sgdp_person_profit_center_id"], name: "index_hr_brief_types_on_sgdp_person_profit_center_id", using: :btree
    t.index ["sgk_employee_account_id"], name: "index_hr_brief_types_on_sgk_employee_account_id", using: :btree
    t.index ["sgk_employee_profit_center_id"], name: "index_hr_brief_types_on_sgk_employee_profit_center_id", using: :btree
    t.index ["sgk_person_account_id"], name: "index_hr_brief_types_on_sgk_person_account_id", using: :btree
    t.index ["sgk_person_profit_center_id"], name: "index_hr_brief_types_on_sgk_person_profit_center_id", using: :btree
    t.index ["trafik_fine_account_id"], name: "index_hr_brief_types_on_trafik_fine_account_id", using: :btree
    t.index ["trafik_fine_profit_center_id"], name: "index_hr_brief_types_on_trafik_fine_profit_center_id", using: :btree
    t.index ["unemployment_employee_account_id"], name: "index_hr_brief_types_on_unemployment_employee_account_id", using: :btree
    t.index ["unemployment_employee_profit_center_id"], name: "index_hr_brief_types_on_unemployment_employee_profit_center_id", using: :btree
    t.index ["unemployment_person_account_id"], name: "index_hr_brief_types_on_unemployment_person_account_id", using: :btree
    t.index ["unemployment_person_profit_center_id"], name: "index_hr_brief_types_on_unemployment_person_profit_center_id", using: :btree
    t.index ["user_id"], name: "index_hr_brief_types_on_user_id", using: :btree
  end

  create_table "hr_departments", force: :cascade do |t|
    t.integer  "office_id"
    t.string   "code",       limit: 20,                       null: false
    t.string   "name",       limit: 100,                      null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "patron_id"
    t.string   "unit",                   default: "employee"
    t.index ["office_id"], name: "index_hr_departments_on_office_id", using: :btree
    t.index ["patron_id"], name: "index_hr_departments_on_patron_id", using: :btree
  end

  create_table "hr_edeclarations", force: :cascade do |t|
    t.integer  "office_id",                                             null: false
    t.integer  "patron_id",                                             null: false
    t.integer  "user_id",                                               null: false
    t.date     "action_date"
    t.integer  "total_personel_count",             default: 0
    t.integer  "year"
    t.integer  "month"
    t.boolean  "article_10",                       default: false
    t.boolean  "article_15",                       default: false
    t.boolean  "article_17",                       default: false
    t.boolean  "article_19",                       default: false
    t.boolean  "article_20",                       default: false
    t.boolean  "article_28",                       default: false
    t.boolean  "declaration",                      default: false
    t.boolean  "realization",                      default: false
    t.string   "status",                           default: "draft"
    t.text     "notes"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "past_months",                      default: 0
    t.integer  "aphb_personel_count",              default: 0
    t.integer  "article_10_count",                 default: 0
    t.integer  "article_15_count",                 default: 0
    t.integer  "article_17_count",                 default: 0
    t.integer  "article_19_count",                 default: 0
    t.integer  "article_20_count",                 default: 0
    t.integer  "article_28_count",                 default: 0
    t.boolean  "article_disabled",                 default: false
    t.integer  "article_disabled_count",           default: 0
    t.integer  "action_level",           limit: 2, default: 0,          null: false
    t.boolean  "all_periods",                      default: false
    t.integer  "last_year",                        default: 0
    t.integer  "last_month",                       default: 0
    t.string   "action_status",                    default: "draft"
    t.boolean  "salary_support",                   default: false
    t.string   "calculation_type",                 default: "standard"
    t.boolean  "disabled_incentive",               default: false
    t.boolean  "additional_incentive",             default: false
    t.index ["office_id"], name: "index_hr_edeclarations_on_office_id", using: :btree
    t.index ["patron_id"], name: "index_hr_edeclarations_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_hr_edeclarations_on_user_id", using: :btree
  end

  create_table "hr_extra_params", force: :cascade do |t|
    t.string   "name"
    t.decimal  "amount",                   default: "0.0"
    t.string   "curr",           limit: 3
    t.string   "period"
    t.string   "parameter_type"
    t.string   "debit_credit"
    t.boolean  "sgk_deduction",            default: false
    t.boolean  "income_tax",               default: false
    t.boolean  "proc_tax",                 default: false
    t.boolean  "prim",                     default: false
    t.string   "brut_net"
    t.text     "notes"
    t.boolean  "is_default",               default: false
    t.integer  "patron_id",                                null: false
    t.integer  "user_id",                                  null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "code"
    t.boolean  "daily",                    default: false
    t.index ["patron_id"], name: "index_hr_extra_params_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_hr_extra_params_on_user_id", using: :btree
  end

  create_table "hr_families", force: :cascade do |t|
    t.integer  "person_id",                                null: false
    t.string   "relationship", limit: 20
    t.string   "name",         limit: 30,                  null: false
    t.string   "surname",      limit: 30,                  null: false
    t.string   "ssn_no",       limit: 20
    t.string   "gender",       limit: 10
    t.date     "birth_date"
    t.string   "occupation",   limit: 30
    t.string   "education",    limit: 30
    t.boolean  "agi",                      default: false
    t.boolean  "disabled",                 default: false
    t.string   "hometel",      limit: 15
    t.string   "business_tel", limit: 15
    t.string   "exttel",       limit: 15
    t.string   "gsm",          limit: 15
    t.string   "email",        limit: 100
    t.string   "postcode",     limit: 5
    t.string   "address",      limit: 255
    t.string   "country_id",   limit: 2
    t.integer  "user_id",                                  null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "doc_no"
    t.date     "doc_date"
    t.boolean  "works",                    default: false
    t.index ["person_id"], name: "index_hr_families_on_person_id", using: :btree
  end

  create_table "hr_gvparams", force: :cascade do |t|
    t.integer  "sgkparam_id", null: false
    t.decimal  "gv_matrah",   null: false
    t.float    "gv_rate",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["sgkparam_id"], name: "index_hr_gvparams_on_sgkparam_id", using: :btree
  end

  create_table "hr_identities", force: :cascade do |t|
    t.integer  "person_id",                  null: false
    t.string   "ssn_no",          limit: 20
    t.string   "dad",             limit: 40
    t.string   "mom",             limit: 40
    t.string   "rh",              limit: 10
    t.string   "identity_serial", limit: 10
    t.string   "identity_no",     limit: 20
    t.string   "birth_place",     limit: 40
    t.string   "city",            limit: 50
    t.string   "county",          limit: 50
    t.string   "district",        limit: 50
    t.string   "ciltno",          limit: 10
    t.string   "ailesirano",      limit: 10
    t.string   "sirano",          limit: 10
    t.date     "card_date"
    t.string   "card_place",      limit: 50
    t.string   "card_note",       limit: 50
    t.string   "card_no",         limit: 20
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.date     "birth_date"
    t.index ["person_id"], name: "index_hr_identities_on_person_id", using: :btree
    t.index ["user_id"], name: "index_hr_identities_on_user_id", using: :btree
  end

  create_table "hr_jobinfos", force: :cascade do |t|
    t.integer  "person_id",                 null: false
    t.date     "job_date",                  null: false
    t.string   "jobtitle",      limit: 100, null: false
    t.integer  "department_id"
    t.integer  "branch_id",                 null: false
    t.string   "location",      limit: 100
    t.integer  "manager_id"
    t.integer  "user_id",                   null: false
    t.text     "notes"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "office_id"
    t.index ["office_id"], name: "index_hr_jobinfos_on_office_id", using: :btree
    t.index ["person_id"], name: "index_hr_jobinfos_on_person_id", using: :btree
    t.index ["user_id"], name: "index_hr_jobinfos_on_user_id", using: :btree
  end

  create_table "hr_offices", force: :cascade do |t|
    t.string   "name",                  limit: 100,                         null: false
    t.string   "title",                 limit: 255,                         null: false
    t.string   "code",                  limit: 20
    t.string   "taxoffice",             limit: 60
    t.string   "taxno",                 limit: 30
    t.string   "work_details",          limit: 100
    t.text     "address"
    t.string   "country_id",            limit: 2
    t.string   "tel",                   limit: 20
    t.string   "fax",                   limit: 20
    t.string   "sgk_branch"
    t.string   "sgk_no"
    t.string   "sgk_docno",             limit: 40
    t.date     "sgk_start_date"
    t.string   "sgk_control_no",        limit: 20
    t.string   "sgk_danger_class",      limit: 1
    t.integer  "work_hours",            limit: 2
    t.integer  "work_accident_rate",    limit: 2
    t.string   "salary_iban",           limit: 40
    t.string   "sgk_iban",              limit: 40
    t.integer  "patron_id",                                                 null: false
    t.integer  "user_id",                                                   null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "tax_no"
    t.string   "sgk_username"
    t.string   "sgk_office_code"
    t.string   "sgk_password"
    t.string   "sgk_office_password"
    t.string   "office_type",                       default: "head_office"
    t.string   "status",                            default: "active"
    t.string   "sgk_intermediary_code"
    t.string   "sector_code"
    t.integer  "city_id"
    t.string   "district"
    t.string   "iskur_no"
    t.string   "nace_code"
    t.index ["city_id"], name: "index_hr_offices_on_city_id", using: :btree
  end

  create_table "hr_official_days", force: :cascade do |t|
    t.string   "name"
    t.date     "date"
    t.string   "day"
    t.float    "rate",       default: 0.0
    t.boolean  "free",       default: false
    t.text     "notes"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "hr_payroll_extras", force: :cascade do |t|
    t.integer  "payroll_id"
    t.string   "debit_credit"
    t.string   "description",       limit: 100
    t.decimal  "amount",                        default: "0.0"
    t.boolean  "affect_brut",                   default: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "person_id"
    t.integer  "patron_id"
    t.integer  "user_id"
    t.integer  "month"
    t.integer  "year"
    t.string   "brut_net"
    t.integer  "extra_param_id"
    t.string   "curr",              limit: 3
    t.date     "doc_date"
    t.string   "status",                        default: "draft"
    t.integer  "payroll_source_id"
    t.integer  "installment_count",             default: 1
    t.integer  "benefit_id"
    t.integer  "payroll_period_id"
    t.index ["benefit_id"], name: "index_hr_payroll_extras_on_benefit_id", using: :btree
    t.index ["extra_param_id"], name: "index_hr_payroll_extras_on_extra_param_id", using: :btree
    t.index ["patron_id"], name: "index_hr_payroll_extras_on_patron_id", using: :btree
    t.index ["payroll_id"], name: "index_hr_payroll_extras_on_payroll_id", using: :btree
    t.index ["payroll_period_id"], name: "index_hr_payroll_extras_on_payroll_period_id", using: :btree
    t.index ["payroll_source_id"], name: "index_hr_payroll_extras_on_payroll_source_id", using: :btree
    t.index ["person_id"], name: "index_hr_payroll_extras_on_person_id", using: :btree
    t.index ["user_id"], name: "index_hr_payroll_extras_on_user_id", using: :btree
  end

  create_table "hr_payroll_periods", force: :cascade do |t|
    t.string   "title",                           null: false
    t.integer  "payroll_year",                    null: false
    t.integer  "payroll_month",                   null: false
    t.integer  "payroll_week"
    t.date     "start_date"
    t.date     "finish_date"
    t.integer  "patron_id",                       null: false
    t.integer  "user_id",                         null: false
    t.text     "notes"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "weekends",      default: 0
    t.string   "status",        default: "draft"
    t.integer  "payroll_count", default: 0
    t.integer  "person_count",  default: 0
  end

  create_table "hr_payroll_sources", force: :cascade do |t|
    t.integer  "person_id",                                                    null: false
    t.integer  "payroll_period_id",                                            null: false
    t.integer  "office_id",                                                    null: false
    t.integer  "department_id",                                                null: false
    t.integer  "sgkparam_id"
    t.decimal  "salary",                                 default: "0.0"
    t.string   "salary_type"
    t.string   "curr",                        limit: 3
    t.decimal  "cumulative_income_tax_base"
    t.string   "sgk_staff_type",              limit: 30
    t.string   "sgk_no"
    t.string   "sgk_job_code"
    t.string   "sgk_declaration_code"
    t.string   "sgk_discount_code"
    t.string   "sgk_25statute_code"
    t.string   "sgk_disability_status"
    t.string   "payment_type"
    t.string   "bank_code"
    t.string   "branch_code"
    t.string   "account_code"
    t.boolean  "included_bes"
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "patron_id",                                                    null: false
    t.integer  "user_id",                                                      null: false
    t.float    "bes_rate",                               default: 0.0
    t.integer  "max_work_day",                           default: 30
    t.integer  "bank_id"
    t.decimal  "agi_rate",                               default: "0.0"
    t.date     "start_date"
    t.date     "finish_date"
    t.boolean  "minimum_wage",                           default: false
    t.string   "job_title"
    t.integer  "person_type_id",                         default: 0
    t.string   "iban_no"
    t.string   "bes_fund",                               default: "interest"
    t.string   "subunit"
    t.string   "brief"
    t.float    "unemployment_person_rate",               default: 0.0
    t.float    "unemployment_employee_rate",             default: 0.0
    t.float    "person_retirement_rate",                 default: 0.0
    t.float    "employee_retirement_rate",               default: 0.0
    t.float    "person_gss_rate",                        default: 0.0
    t.float    "employee_gss_rate",                      default: 0.0
    t.float    "person_sgdp_rate",                       default: 0.0
    t.float    "employee_sgdp_rate",                     default: 0.0
    t.float    "person_work_accident_rate",              default: 0.0
    t.float    "employee_work_accident_rate",            default: 0.0
    t.integer  "child_count",                            default: 0
    t.boolean  "wife_status",                            default: false
    t.string   "martial_status",                         default: "single"
    t.string   "bes_status",                             default: "cancelled"
    t.date     "hire_date"
    t.date     "fire_date"
    t.integer  "brief_type_id"
    t.index ["bank_id"], name: "index_hr_payroll_sources_on_bank_id", using: :btree
    t.index ["brief_type_id"], name: "index_hr_payroll_sources_on_brief_type_id", using: :btree
    t.index ["department_id"], name: "index_hr_payroll_sources_on_department_id", using: :btree
    t.index ["office_id"], name: "index_hr_payroll_sources_on_office_id", using: :btree
    t.index ["patron_id"], name: "index_hr_payroll_sources_on_patron_id", using: :btree
    t.index ["payroll_period_id"], name: "index_hr_payroll_sources_on_payroll_period_id", using: :btree
    t.index ["person_id"], name: "index_hr_payroll_sources_on_person_id", using: :btree
    t.index ["sgkparam_id"], name: "index_hr_payroll_sources_on_sgkparam_id", using: :btree
    t.index ["user_id"], name: "index_hr_payroll_sources_on_user_id", using: :btree
  end

  create_table "hr_payroll_workdays", force: :cascade do |t|
    t.integer  "payroll_id"
    t.integer  "workday_param_id",                               null: false
    t.integer  "work_day",                     default: 0
    t.string   "work_hour",         limit: 5
    t.string   "reason_code",       limit: 30
    t.text     "notes"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "is_default",                   default: false
    t.integer  "person_id",                                      null: false
    t.integer  "patron_id",                                      null: false
    t.integer  "user_id",                                        null: false
    t.date     "work_date"
    t.string   "status",                       default: "draft"
    t.integer  "payroll_source_id"
    t.date     "start_date"
    t.date     "finish_date"
    t.index ["patron_id"], name: "index_hr_payroll_workdays_on_patron_id", using: :btree
    t.index ["payroll_id"], name: "index_hr_payroll_workdays_on_payroll_id", using: :btree
    t.index ["payroll_source_id"], name: "index_hr_payroll_workdays_on_payroll_source_id", using: :btree
    t.index ["person_id"], name: "index_hr_payroll_workdays_on_person_id", using: :btree
    t.index ["user_id"], name: "index_hr_payroll_workdays_on_user_id", using: :btree
    t.index ["workday_param_id"], name: "index_hr_payroll_workdays_on_workday_param_id", using: :btree
  end

  create_table "hr_payrolls", force: :cascade do |t|
    t.integer  "payroll_source_id",                                                   null: false
    t.integer  "payroll_period_id",                                                   null: false
    t.integer  "person_id",                                                           null: false
    t.integer  "office_id",                                                           null: false
    t.integer  "department_id",                                                       null: false
    t.decimal  "cumulative_income_tax_base"
    t.decimal  "brut_salary",                         default: "0.0"
    t.decimal  "brut_salary_monthly",                 default: "0.0"
    t.decimal  "net_salary",                          default: "0.0"
    t.integer  "total_days",                          default: 0
    t.integer  "overtime_day",                        default: 0
    t.decimal  "overtime_salary",                     default: "0.0"
    t.decimal  "sgk_tax_base",                        default: "0.0"
    t.decimal  "sgk_person_prim",                     default: "0.0"
    t.decimal  "sgk_employee_prim",                   default: "0.0"
    t.decimal  "unemployment_tax_base",               default: "0.0"
    t.decimal  "unemployment_person_prim",            default: "0.0"
    t.decimal  "unemployment_employee_prim",          default: "0.0"
    t.decimal  "proc_tax_base",                       default: "0.0"
    t.decimal  "proc_tax_prim",                       default: "0.0"
    t.decimal  "income_tax_base",                     default: "0.0"
    t.decimal  "income_tax",                          default: "0.0"
    t.decimal  "disability_discount",                 default: "0.0"
    t.decimal  "agi_base",                            default: "0.0"
    t.decimal  "agi_prim",                            default: "0.0"
    t.decimal  "total_person_salary_deduction",       default: "0.0"
    t.decimal  "total_employee_salary_deduction",     default: "0.0"
    t.decimal  "total_perquisite",                    default: "0.0"
    t.decimal  "rounding_total",                      default: "0.0"
    t.string   "status"
    t.decimal  "bes_prim",                            default: "0.0"
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.integer  "patron_id",                                                           null: false
    t.integer  "user_id",                                                             null: false
    t.integer  "payroll_days"
    t.decimal  "net_salary_monthly",                  default: "0.0"
    t.boolean  "calculated",                          default: true
    t.decimal  "general_total",                       default: "0.0"
    t.decimal  "total_salary_deduction",              default: "0.0"
    t.decimal  "total_discount",                      default: "0.0"
    t.decimal  "overtime_total",                      default: "0.0"
    t.integer  "weekend_days",                        default: 0
    t.decimal  "weekend_salary_net",                  default: "0.0"
    t.decimal  "daily_salary_net",                    default: "0.0"
    t.decimal  "hourly_salary",                       default: "0.0"
    t.decimal  "overtime_salary_brut",                default: "0.0"
    t.decimal  "overtime_salary_net",                 default: "0.0"
    t.decimal  "subsistence_brut",                    default: "0.0"
    t.decimal  "subsistence_net",                     default: "0.0"
    t.decimal  "prim_brut",                           default: "0.0"
    t.decimal  "prim_net",                            default: "0.0"
    t.decimal  "timeoff_salary_brut",                 default: "0.0"
    t.decimal  "timeoff_salary_net",                  default: "0.0"
    t.decimal  "notice_payment_brut",                 default: "0.0"
    t.decimal  "notice_payment_net",                  default: "0.0"
    t.decimal  "severance_payment_brut",              default: "0.0"
    t.decimal  "severance_payment_net",               default: "0.0"
    t.decimal  "advence_deduction_brut",              default: "0.0"
    t.decimal  "advence_deduction_net",               default: "0.0"
    t.decimal  "levy_deduction_brut",                 default: "0.0"
    t.decimal  "levy_deduction_net",                  default: "0.0"
    t.decimal  "trafik_fine_brut",                    default: "0.0"
    t.decimal  "trafik_fine_net",                     default: "0.0"
    t.decimal  "debit_deduction_brut",                default: "0.0"
    t.decimal  "debit_deduction_net",                 default: "0.0"
    t.decimal  "public_allowance_brut",               default: "0.0"
    t.decimal  "public_allowance_net",                default: "0.0"
    t.decimal  "festival_allowance_brut",             default: "0.0"
    t.decimal  "festival_allowance_net",              default: "0.0"
    t.decimal  "housing_benefit_brut",                default: "0.0"
    t.decimal  "housing_benefit_net",                 default: "0.0"
    t.decimal  "fuel_benefit_brut",                   default: "0.0"
    t.decimal  "fuel_benefit_net",                    default: "0.0"
    t.decimal  "road_benefit_brut",                   default: "0.0"
    t.decimal  "road_benefit_net",                    default: "0.0"
    t.decimal  "food_benefit_brut",                   default: "0.0"
    t.decimal  "food_benefit_net",                    default: "0.0"
    t.integer  "reported_day",                        default: 0
    t.float    "reported_hour",                       default: 0.0
    t.decimal  "reported_brut",                       default: "0.0"
    t.decimal  "reported_net",                        default: "0.0"
    t.integer  "absent_day",                          default: 0
    t.float    "absent_hour",                         default: 0.0
    t.decimal  "absent_brut",                         default: "0.0"
    t.decimal  "absent_net",                          default: "0.0"
    t.integer  "festival_200_day",                    default: 0
    t.float    "festival_200_hour",                   default: 0.0
    t.decimal  "festival_200_brut",                   default: "0.0"
    t.decimal  "festival_200_net",                    default: "0.0"
    t.integer  "overtime_125_day",                    default: 0
    t.float    "overtime_125_hour",                   default: 0.0
    t.decimal  "overtime_125_brut",                   default: "0.0"
    t.decimal  "overtime_125_net",                    default: "0.0"
    t.integer  "overtime_150_day",                    default: 0
    t.float    "overtime_150_hour",                   default: 0.0
    t.decimal  "overtime_150_brut",                   default: "0.0"
    t.decimal  "overtime_150_net",                    default: "0.0"
    t.integer  "overtime_200_day",                    default: 0
    t.float    "overtime_200_hour",                   default: 0.0
    t.decimal  "overtime_200_brut",                   default: "0.0"
    t.decimal  "overtime_200_net",                    default: "0.0"
    t.decimal  "net_salary_payroll",                  default: "0.0"
    t.decimal  "brut_salary_payroll",                 default: "0.0"
    t.integer  "unpaid_day",                          default: 0
    t.float    "unpaid_hour",                         default: 0.0
    t.decimal  "unpaid_brut",                         default: "0.0"
    t.decimal  "unpaid_net",                          default: "0.0"
    t.decimal  "weekend_salary_brut",                 default: "0.0"
    t.decimal  "additional_agi_prim",                 default: "0.0"
    t.integer  "reduced_days"
    t.integer  "work_day"
    t.float    "work_hour"
    t.decimal  "disability_discount_base",            default: "0.0"
    t.decimal  "turnover_sgk_base",                   default: "0.0"
    t.decimal  "remained_turnover_sgk_base",          default: "0.0"
    t.integer  "official_days",                       default: 0
    t.decimal  "official_salary_brut",                default: "0.0"
    t.decimal  "official_salary_net",                 default: "0.0"
    t.decimal  "daily_salary_brut",                   default: "0.0"
    t.string   "bes_status"
    t.string   "payment_type",                        default: "bank"
    t.decimal  "income_tax_discount",                 default: "0.0"
    t.decimal  "health_insurance_brut",               default: "0.0"
    t.decimal  "health_insurance_net",                default: "0.0"
    t.decimal  "bounty_net",                          default: "0.0"
    t.decimal  "bounty_brut",                         default: "0.0"
    t.decimal  "total_private_deductions_brut",       default: "0.0"
    t.decimal  "total_private_deductions_net",        default: "0.0"
    t.decimal  "total_overtime_benefits_brut",        default: "0.0"
    t.decimal  "total_overtime_benefits_net",         default: "0.0"
    t.decimal  "total_benefits_brut",                 default: "0.0"
    t.decimal  "total_benefits_net",                  default: "0.0"
    t.decimal  "normal_net",                          default: "0.0"
    t.decimal  "normal_brut",                         default: "0.0"
    t.decimal  "normal_day",                          default: "0.0"
    t.decimal  "normal_hour",                         default: "0.0"
    t.decimal  "health_insurance_deduction_brut",     default: "0.0"
    t.decimal  "health_insurance_deduction_net",      default: "0.0"
    t.decimal  "sgk_employee_discount",               default: "0.0"
    t.decimal  "discount_5510",                       default: "0.0"
    t.decimal  "discount_6111",                       default: "0.0"
    t.decimal  "discount_27103",                      default: "0.0"
    t.decimal  "sgdp_tax_base",                       default: "0.0"
    t.decimal  "sgdp_person_prim",                    default: "0.0"
    t.decimal  "sgdp_employee_prim",                  default: "0.0"
    t.decimal  "employee_income_tax_discounts",       default: "0.0"
    t.decimal  "person_retirement_prim",              default: "0.0"
    t.decimal  "employee_retirement_prim",            default: "0.0"
    t.decimal  "person_gss_prim",                     default: "0.0"
    t.decimal  "employee_gss_prim",                   default: "0.0"
    t.decimal  "person_sgk_support_prim",             default: "0.0"
    t.decimal  "employee_sgk_support_prim",           default: "0.0"
    t.decimal  "person_work_accident_prim",           default: "0.0"
    t.decimal  "employee_work_accident_prim",         default: "0.0"
    t.decimal  "employee_income_tax_discount_amount", default: "0.0"
    t.decimal  "honorarium_net",                      default: "0.0"
    t.decimal  "honorarium_brut",                     default: "0.0"
    t.decimal  "employee_cost",                       default: -> { "(0)::numeric" }
    t.decimal  "discounted_cost",                     default: -> { "(0)::numeric" }
    t.decimal  "used_turnover_sgk_base_first",        default: "0.0"
    t.decimal  "used_turnover_sgk_base_second",       default: "0.0"
    t.integer  "turnover_first_payroll_id"
    t.integer  "turnover_second_payroll_id"
    t.decimal  "person_health_insurance_brut",        default: "0.0"
    t.decimal  "person_health_insurance_net",         default: "0.0"
    t.decimal  "person_health_insurance_discount",    default: "0.0"
    t.decimal  "calculated_turnover_sgk_amount",      default: "0.0"
    t.decimal  "discount_27103_unemployment",         default: "0.0"
    t.decimal  "discount_14857",                      default: "0.0"
    t.decimal  "discount_5510_base",                  default: "0.0"
    t.decimal  "discount_27103_base",                 default: "0.0"
    t.decimal  "discount_27103_unemployment_base",    default: "0.0"
    t.decimal  "discount_6111_base",                  default: "0.0"
    t.decimal  "discount_14857_base",                 default: "0.0"
    t.index ["department_id"], name: "index_hr_payrolls_on_department_id", using: :btree
    t.index ["office_id"], name: "index_hr_payrolls_on_office_id", using: :btree
    t.index ["patron_id"], name: "index_hr_payrolls_on_patron_id", using: :btree
    t.index ["payroll_period_id"], name: "index_hr_payrolls_on_payroll_period_id", using: :btree
    t.index ["payroll_source_id"], name: "index_hr_payrolls_on_payroll_source_id", using: :btree
    t.index ["person_id"], name: "index_hr_payrolls_on_person_id", using: :btree
    t.index ["turnover_first_payroll_id"], name: "index_hr_payrolls_on_turnover_first_payroll_id", using: :btree
    t.index ["turnover_second_payroll_id"], name: "index_hr_payrolls_on_turnover_second_payroll_id", using: :btree
    t.index ["user_id"], name: "index_hr_payrolls_on_user_id", using: :btree
  end

  create_table "hr_people", force: :cascade do |t|
    t.integer  "person_no"
    t.string   "name",               limit: 30,                        null: false
    t.string   "surname",            limit: 30,                        null: false
    t.string   "gender",             limit: 10
    t.date     "hire_date"
    t.date     "birth_date"
    t.string   "status",             limit: 10,  default: "active"
    t.string   "hometel",            limit: 15
    t.string   "business_tel",       limit: 15
    t.string   "exttel",             limit: 15
    t.string   "gsm",                limit: 15
    t.string   "skype",              limit: 30
    t.string   "email",              limit: 100
    t.string   "personal_email",     limit: 100
    t.string   "postcode",           limit: 5
    t.string   "address",            limit: 255
    t.string   "city",               limit: 100
    t.string   "state",              limit: 30
    t.string   "country_id",         limit: 2
    t.string   "twitter",            limit: 30
    t.string   "facebook",           limit: 50
    t.string   "linkedin",           limit: 50
    t.string   "website",            limit: 30
    t.string   "ssn_no",             limit: 20
    t.string   "nation",             limit: 2
    t.string   "martial_status",     limit: 20
    t.string   "second_language",    limit: 30
    t.string   "avatar",             limit: 255
    t.integer  "user_id",                                              null: false
    t.integer  "branch_id"
    t.integer  "patron_id",                                            null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.boolean  "trashed",                        default: false
    t.decimal  "salary",                         default: "0.0"
    t.string   "salary_type"
    t.string   "curr",               limit: 3
    t.string   "payment_type"
    t.string   "bank_code"
    t.string   "branch_code"
    t.string   "account_code"
    t.boolean  "included_bes"
    t.integer  "person_type_id",                                       null: false
    t.string   "first_surname",      limit: 50
    t.date     "fire_date"
    t.string   "fire_cause"
    t.decimal  "bes_rate",                       default: "0.0"
    t.string   "jobtitle"
    t.integer  "department_id"
    t.integer  "manager_id"
    t.integer  "office_id"
    t.date     "bes_exit_date"
    t.boolean  "minimum_wage",                   default: false
    t.text     "notes"
    t.string   "bank_name",          limit: 255
    t.string   "iban_no",            limit: 255
    t.integer  "bank_id"
    t.integer  "system_user_id"
    t.date     "first_hire_date"
    t.string   "bank_branch",        limit: 50
    t.string   "education",          limit: 30
    t.string   "military_service"
    t.string   "subunit"
    t.string   "brief"
    t.integer  "transfer_person_id"
    t.string   "collar",                         default: "white"
    t.string   "bes_status",                     default: "cancelled"
    t.string   "bes_fund",                       default: "interest"
    t.date     "tenured_date"
    t.integer  "brief_type_id"
    t.string   "mother_surname"
    t.string   "fire_cause_iskur"
    t.index ["bank_id"], name: "index_hr_people_on_bank_id", using: :btree
    t.index ["brief_type_id"], name: "index_hr_people_on_brief_type_id", using: :btree
    t.index ["department_id"], name: "index_hr_people_on_department_id", using: :btree
    t.index ["manager_id"], name: "index_hr_people_on_manager_id", using: :btree
    t.index ["office_id"], name: "index_hr_people_on_office_id", using: :btree
    t.index ["patron_id"], name: "index_hr_people_on_patron_id", using: :btree
    t.index ["person_type_id"], name: "index_hr_people_on_person_type_id", using: :btree
    t.index ["system_user_id"], name: "index_hr_people_on_system_user_id", using: :btree
    t.index ["transfer_person_id"], name: "index_hr_people_on_transfer_person_id", using: :btree
  end

  create_table "hr_person_sgkparams", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "sgk_staff_type",              limit: 30
    t.string   "sgk_no"
    t.string   "sgk_job_code"
    t.string   "sgk_declaration_code"
    t.string   "sgk_discount_code"
    t.string   "sgk_25statute_code"
    t.string   "sgk_disability_status"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.decimal  "cumulative_income_tax_base"
    t.date     "terminate_date"
    t.string   "disability_declaration_code", limit: 10
    t.index ["person_id"], name: "index_hr_person_sgkparams_on_person_id", using: :btree
  end

  create_table "hr_person_types", force: :cascade do |t|
    t.string   "name",                   limit: 30
    t.float    "code"
    t.decimal  "person_sgk",                        default: "0.0"
    t.decimal  "employee_sgk",                      default: "0.0"
    t.decimal  "person_gss",                        default: "0.0"
    t.decimal  "employee_gss",                      default: "0.0"
    t.decimal  "person_sgk_discount",               default: "0.0"
    t.decimal  "employee_sgk_discount",             default: "0.0"
    t.decimal  "person_sgdp",                       default: "0.0"
    t.decimal  "employee_sgdp",                     default: "0.0"
    t.decimal  "unemployment_person",               default: "0.0"
    t.decimal  "unemployment_employee",             default: "0.0"
    t.decimal  "person_work_accident",              default: "0.0"
    t.decimal  "employee_work_accident",            default: "0.0"
    t.boolean  "income_tax",                        default: false
    t.boolean  "proc_tax",                          default: false
    t.boolean  "bes",                               default: false
    t.boolean  "agi",                               default: false
    t.decimal  "rate",                              default: "100.0"
    t.text     "notes"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  create_table "hr_sgkparams", force: :cascade do |t|
    t.integer  "yil",                                    null: false
    t.integer  "ay",                                     null: false
    t.decimal  "asgari_ucret"
    t.decimal  "sgk_taban"
    t.decimal  "sgk_tavan"
    t.float    "normal_isci_oran"
    t.float    "normal_isveren_oran"
    t.float    "saglik_isci_oran"
    t.float    "saglik_isveren_oran"
    t.float    "emekli_isci_oran"
    t.float    "emekli_isveren_oran"
    t.float    "issizlik_isci_oran"
    t.float    "issizlik_isveren_oran"
    t.integer  "prim_gun"
    t.float    "damga_oran"
    t.float    "engelli_1_oran"
    t.float    "engelli_2_oran"
    t.float    "engelli_3_oran"
    t.integer  "ihbar1_gun"
    t.integer  "ihbar2_gun"
    t.integer  "ihbar3_gun"
    t.integer  "ihbar4_gun"
    t.integer  "kidem_gun"
    t.decimal  "kidem_tavan"
    t.float    "engelli_sayi_oran"
    t.float    "hukumlu_sayi_oran"
    t.float    "teror_magdur_sayi_oran"
    t.float    "bes_isci_oran"
    t.float    "bes_isveren_oran"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.decimal  "asgari_ucret_brut",      default: "0.0"
    t.decimal  "sgk_indirim_oss",        default: "0.0"
    t.decimal  "gv_indirim_oss",         default: "0.0"
  end

  create_table "hr_static_codes", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "code_type",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "country_id"
    t.index ["code_type"], name: "index_hr_static_codes_on_code_type", using: :btree
  end

  create_table "hr_timeoff_searches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_timeoffs", force: :cascade do |t|
    t.integer  "person_id",                                     null: false
    t.date     "start_date",                                    null: false
    t.date     "finish_date",                                   null: false
    t.string   "reason_code",    limit: 30,                     null: false
    t.string   "status",         limit: 10, default: "pending", null: false
    t.text     "person_notes"
    t.integer  "approver_id"
    t.date     "approval_date"
    t.text     "approver_notes"
    t.integer  "patron_id",                                     null: false
    t.integer  "user_id",                                       null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "debit",                     default: 0
    t.integer  "credit",                    default: 0
    t.date     "beginning_date"
    t.integer  "timeoff_year"
    t.string   "debit_credit"
    t.index ["person_id"], name: "index_hr_timeoffs_on_person_id", using: :btree
  end

  create_table "hr_timeparams", force: :cascade do |t|
    t.integer  "sgkparam_id", null: false
    t.string   "time_code",   null: false
    t.integer  "time_rate",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["sgkparam_id"], name: "index_hr_timeparams_on_sgkparam_id", using: :btree
  end

  create_table "hr_workday_params", force: :cascade do |t|
    t.string   "name",       limit: 50
    t.float    "rate"
    t.boolean  "is_default",            default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "patron_id"
    t.integer  "user_id"
    t.string   "category"
    t.string   "code"
    t.index ["patron_id"], name: "index_hr_workday_params_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_hr_workday_params_on_user_id", using: :btree
  end

  create_table "logistics_arrivals", force: :cascade do |t|
    t.integer  "loading_id"
    t.date     "unload_date"
    t.date     "delivery_date"
    t.string   "unload_point",      limit: 10
    t.boolean  "post_trans",                    default: false
    t.string   "unload_place_code", limit: 20
    t.string   "unload_place",      limit: 60
    t.string   "unload_city",       limit: 60
    t.string   "country_id",        limit: 2,                   null: false
    t.string   "district",          limit: 30
    t.string   "postcode",          limit: 5
    t.string   "address",           limit: 100
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "gmaps"
    t.string   "consignee",         limit: 60
    t.string   "notify",            limit: 60
    t.string   "notify2",           limit: 60
    t.string   "deliver",           limit: 60
    t.string   "custom",            limit: 60
    t.string   "customofficer",     limit: 60
    t.string   "statement",         limit: 20
    t.date     "statement_date"
    t.integer  "user_id",                                       null: false
    t.integer  "patron_id",                                     null: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lead_id"
    t.index ["loading_id"], name: "index_logistics_arrivals_on_loading_id", using: :btree
    t.index ["patron_id", "country_id"], name: "index_logistics_arrivals_on_patron_id_and_country_id", using: :btree
  end

  create_table "logistics_barems", force: :cascade do |t|
    t.string   "parent_type",                 null: false
    t.integer  "parent_id",                   null: false
    t.decimal  "weight",      default: "0.0"
    t.float    "rate",        default: 0.0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["parent_type", "parent_id"], name: "index_logistics_barems_on_parent_type_and_parent_id", using: :btree
  end

  create_table "logistics_bookings", force: :cascade do |t|
    t.integer  "operation_id",                                    null: false
    t.date     "order_date",                                      null: false
    t.string   "load_type",       limit: 20
    t.string   "customer_name",   limit: 100
    t.integer  "customer_id"
    t.string   "contact_name",    limit: 100
    t.integer  "contact_id"
    t.string   "sender_name",     limit: 100
    t.integer  "sender_id"
    t.string   "consignee_name",  limit: 100
    t.integer  "consignee_id"
    t.string   "load_coun",       limit: 2,                       null: false
    t.string   "load_postcode",   limit: 10
    t.string   "load_address",    limit: 100
    t.string   "load_3words",     limit: 50
    t.string   "unload_coun",     limit: 2,                       null: false
    t.string   "unload_postcode", limit: 10
    t.string   "unload_address",  limit: 100
    t.string   "unload_3words",   limit: 50
    t.string   "commodity",       limit: 100
    t.string   "pack",            limit: 100
    t.string   "dimensions",      limit: 100
    t.float    "weight",                      default: 0.0
    t.string   "weight_unit",     limit: 20
    t.float    "volume",                      default: 0.0
    t.float    "lade",                        default: 0.0
    t.string   "customs_name",    limit: 100
    t.integer  "customs_id"
    t.string   "incoterm",        limit: 20
    t.string   "depot_date"
    t.string   "vehicles"
    t.date     "delivery_date"
    t.string   "status",          limit: 20,  default: "pending"
    t.text     "notes"
    t.string   "color",           limit: 10
    t.string   "reference",       limit: 30
    t.integer  "saler_id",                                        null: false
    t.integer  "loading_id"
    t.integer  "branch_id",                                       null: false
    t.integer  "user_id",                                         null: false
    t.integer  "patron_id",                                       null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["branch_id"], name: "index_logistics_bookings_on_branch_id", using: :btree
    t.index ["consignee_id"], name: "index_logistics_bookings_on_consignee_id", using: :btree
    t.index ["contact_id"], name: "index_logistics_bookings_on_contact_id", using: :btree
    t.index ["customer_id"], name: "index_logistics_bookings_on_customer_id", using: :btree
    t.index ["customs_id"], name: "index_logistics_bookings_on_customs_id", using: :btree
    t.index ["loading_id"], name: "index_logistics_bookings_on_loading_id", using: :btree
    t.index ["operation_id"], name: "index_logistics_bookings_on_operation_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_bookings_on_patron_id", using: :btree
    t.index ["saler_id"], name: "index_logistics_bookings_on_saler_id", using: :btree
    t.index ["sender_id"], name: "index_logistics_bookings_on_sender_id", using: :btree
    t.index ["user_id"], name: "index_logistics_bookings_on_user_id", using: :btree
  end

  create_table "logistics_containers", force: :cascade do |t|
    t.string   "name",            limit: 40,                  null: false
    t.string   "container_type",  limit: 40
    t.string   "sealno",          limit: 40
    t.integer  "loading_id",                                  null: false
    t.integer  "patron_id",                                   null: false
    t.integer  "free_day",                    default: 0
    t.date     "due_date"
    t.decimal  "demurrage",                   default: "0.0"
    t.string   "demurrage_curr",  limit: 3
    t.text     "notes"
    t.boolean  "trashed",                     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "weight",                      default: "0.0"
    t.integer  "vehicle_id"
    t.integer  "wagon_id"
    t.datetime "taking_date"
    t.datetime "left_date"
    t.integer  "taking_place_id"
    t.integer  "left_place_id"
    t.string   "uuid",            limit: 100
    t.index ["loading_id"], name: "index_logistics_containers_on_loading_id", using: :btree
    t.index ["name", "loading_id"], name: "index_logistics_containers_on_name_and_loading_id", unique: true, using: :btree
    t.index ["patron_id"], name: "index_logistics_containers_on_patron_id", using: :btree
  end

  create_table "logistics_costforms", force: :cascade do |t|
    t.string   "title",          limit: 100,                    null: false
    t.string   "form_type",      limit: 30,                     null: false
    t.decimal  "total_cost",                 default: "0.0"
    t.string   "payoff_curr",    limit: 3,                      null: false
    t.integer  "personal_id"
    t.integer  "position_id"
    t.string   "status",         limit: 10,  default: "active", null: false
    t.date     "payoff_date"
    t.integer  "branch_id",                                     null: false
    t.integer  "patron_id",                                     null: false
    t.integer  "user_id",                                       null: false
    t.text     "notes"
    t.string   "comments_count", limit: 255, default: "0"
    t.string   "costs_count",    limit: 255, default: "0"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logistics_costs", force: :cascade do |t|
    t.string   "title",          limit: 100
    t.string   "cost_type",      limit: 30
    t.date     "cost_date"
    t.string   "document_no",    limit: 255
    t.decimal  "price",                      default: "0.0",    null: false
    t.string   "price_curr",     limit: 3,                      null: false
    t.decimal  "form_price",                 default: "0.0"
    t.string   "form_curr",      limit: 3
    t.decimal  "exchange_rate",              default: "1.0"
    t.date     "exchange_date"
    t.string   "parent_type",    limit: 40
    t.integer  "parent_id"
    t.integer  "position_id"
    t.integer  "finitem_id"
    t.integer  "personal_id"
    t.string   "company_name",   limit: 50
    t.string   "staff_name",     limit: 50
    t.string   "status",         limit: 10,  default: "active"
    t.text     "notes"
    t.integer  "branch_id",                                     null: false
    t.integer  "patron_id",                                     null: false
    t.integer  "user_id",                                       null: false
    t.integer  "comments_count",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "route_id"
    t.integer  "driver_id"
    t.integer  "company_id"
    t.integer  "vat_id"
    t.string   "country_id",     limit: 20
    t.index ["branch_id"], name: "index_logistics_costs_on_branch_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_logistics_costs_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_costs_on_patron_id", using: :btree
  end

  create_table "logistics_customsdocs", force: :cascade do |t|
    t.integer  "guarantor_id"
    t.string   "doc_type",              limit: 20,                     null: false
    t.string   "vehicle",               limit: 50,                     null: false
    t.string   "vehicle_country_id",    limit: 2,                      null: false
    t.string   "load_country_id",       limit: 2
    t.text     "load_place"
    t.string   "unload_country_id",     limit: 2,                      null: false
    t.text     "unload_place"
    t.boolean  "is_container",                     default: false
    t.boolean  "is_partial",                       default: false
    t.integer  "goods_count",                      default: 1
    t.float    "brut_wg"
    t.integer  "packages_count"
    t.string   "load_customs_code"
    t.string   "unload_customs_code"
    t.string   "transit_customs_codes"
    t.string   "transit_country_ids"
    t.string   "status",                limit: 30, default: "pending", null: false
    t.integer  "user_id",                                              null: false
    t.integer  "patron_id",                                            null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["patron_id"], name: "index_logistics_customsdocs_on_patron_id", using: :btree
  end

  create_table "logistics_customsgoods", force: :cascade do |t|
    t.integer "customsdoc_id",                     null: false
    t.string  "sender",               limit: 255
    t.string  "sender_taxno",         limit: 20
    t.string  "consignee",            limit: 255
    t.string  "consignee_taxno",      limit: 20
    t.string  "gtip_no",              limit: 100
    t.string  "commodity",            limit: 1000
    t.float   "brut_wg"
    t.float   "net_wg"
    t.string  "exp_customs_no"
    t.string  "exp_customs_type"
    t.string  "exp_customs_partial"
    t.string  "pre_documents_no"
    t.string  "additional_documents"
    t.integer "packages_count"
    t.string  "marks"
    t.decimal "invoice_amount"
    t.integer "invoice_curr"
    t.index ["customsdoc_id"], name: "index_logistics_customsgoods_on_customsdoc_id", using: :btree
  end

  create_table "logistics_departures", force: :cascade do |t|
    t.integer  "loading_id"
    t.date     "load_date"
    t.date     "pickup_date"
    t.string   "load_point",      limit: 10
    t.boolean  "pre_trans",                   default: false
    t.string   "load_place_code", limit: 20
    t.string   "load_place",      limit: 60
    t.string   "load_city",       limit: 60
    t.string   "country_id",      limit: 2
    t.string   "district",        limit: 30
    t.string   "postcode",        limit: 5
    t.string   "address",         limit: 100
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "gmaps"
    t.string   "loader",          limit: 60
    t.string   "sender",          limit: 60
    t.string   "custom",          limit: 60
    t.string   "customofficer",   limit: 60
    t.string   "statement",       limit: 20
    t.date     "statement_date"
    t.integer  "user_id",                                     null: false
    t.integer  "patron_id",                                   null: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lead_id"
    t.index ["loading_id"], name: "index_logistics_departures_on_loading_id", using: :btree
    t.index ["patron_id", "country_id"], name: "index_logistics_departures_on_patron_id_and_country_id", using: :btree
  end

  create_table "logistics_expense_forms", force: :cascade do |t|
    t.string   "reference",          limit: 30,                    null: false
    t.decimal  "total_amount",                  default: "0.0"
    t.string   "curr",               limit: 10
    t.date     "form_date"
    t.decimal  "balance",                       default: "0.0"
    t.string   "status",             limit: 10, default: "active", null: false
    t.integer  "comments_count",                default: 0
    t.text     "notes"
    t.date     "start_date"
    t.date     "finish_date"
    t.integer  "start_km"
    t.integer  "finish_km"
    t.integer  "agreement_id"
    t.integer  "driver_id"
    t.integer  "person_id"
    t.integer  "patron_id",                                        null: false
    t.integer  "user_id",                                          null: false
    t.integer  "branch_id",                                        null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "approver_id"
    t.integer  "route_id"
    t.decimal  "initial_fuel_liter",            default: "0.0"
    t.decimal  "depot_liter",                   default: "0.0"
    t.string   "tariff_type"
    t.decimal  "trip_data_km"
    t.index ["agreement_id"], name: "index_logistics_expense_forms_on_agreement_id", using: :btree
    t.index ["branch_id"], name: "index_logistics_expense_forms_on_branch_id", using: :btree
    t.index ["driver_id"], name: "index_logistics_expense_forms_on_driver_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_expense_forms_on_patron_id", using: :btree
    t.index ["person_id"], name: "index_logistics_expense_forms_on_person_id", using: :btree
    t.index ["user_id"], name: "index_logistics_expense_forms_on_user_id", using: :btree
  end

  create_table "logistics_expense_forms_positions", force: :cascade do |t|
    t.integer "position_id",     null: false
    t.integer "expense_form_id", null: false
    t.index ["expense_form_id"], name: "index_logistics_expense_forms_positions_on_expense_form_id", using: :btree
    t.index ["position_id"], name: "index_logistics_expense_forms_positions_on_position_id", using: :btree
  end

  create_table "logistics_expense_forms_voyages", force: :cascade do |t|
    t.integer "voyage_id",       null: false
    t.integer "expense_form_id", null: false
    t.index ["expense_form_id"], name: "index_logistics_expense_forms_voyages_on_expense_form_id", using: :btree
    t.index ["voyage_id"], name: "index_logistics_expense_forms_voyages_on_voyage_id", using: :btree
  end

  create_table "logistics_extralines", force: :cascade do |t|
    t.string   "parent_type",                           null: false
    t.integer  "parent_id",                             null: false
    t.integer  "finitem_id",                            null: false
    t.string   "reference",   limit: 100
    t.text     "notes"
    t.float    "price",                   default: 0.0
    t.string   "curr",        limit: 3
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "country_id",  limit: 2
    t.index ["finitem_id"], name: "index_logistics_extralines_on_finitem_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_logistics_extralines_on_parent_type_and_parent_id", using: :btree
  end

  create_table "logistics_incidents", force: :cascade do |t|
    t.string   "reference",              limit: 30,                    null: false
    t.date     "incident_date"
    t.string   "incident_place"
    t.integer  "voyage_id"
    t.integer  "insurance_company_id"
    t.string   "operation_type",         limit: 50
    t.integer  "company_id"
    t.decimal  "incident_price",                    default: "0.0"
    t.string   "incident_curr",          limit: 5
    t.string   "status",                            default: "active"
    t.string   "incident_type"
    t.string   "insurance_type"
    t.date     "insurance_date"
    t.text     "notes"
    t.decimal  "insurance_amount",                  default: "0.0"
    t.string   "insurance_curr",         limit: 5
    t.date     "insurance_payment_date"
    t.decimal  "payment_amount",                    default: "0.0"
    t.string   "payment_curr",           limit: 5
    t.date     "payment_date"
    t.integer  "patron_id",                                            null: false
    t.integer  "user_id",                                              null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "country_id",             limit: 2
    t.string   "police_no"
    t.string   "doc_no"
    t.jsonb    "user_fields"
    t.integer  "operation_id"
    t.integer  "comments_count",                    default: 0
    t.index ["company_id"], name: "index_logistics_incidents_on_company_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_incidents_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_logistics_incidents_on_user_id", using: :btree
    t.index ["voyage_id"], name: "index_logistics_incidents_on_voyage_id", using: :btree
  end

  create_table "logistics_incoterms", force: :cascade do |t|
    t.string   "code",       limit: 30, null: false
    t.string   "name",       limit: 50, null: false
    t.text     "desc"
    t.integer  "user_id",               null: false
    t.integer  "patron_id",             null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["patron_id"], name: "index_logistics_incoterms_on_patron_id", using: :btree
  end

  create_table "logistics_lead_contacts", force: :cascade do |t|
    t.integer  "lead_id",    null: false
    t.integer  "contact_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logistics_leadlines", force: :cascade do |t|
    t.integer  "lead_id",                                         null: false
    t.string   "title",            limit: 255,                    null: false
    t.integer  "company_id"
    t.string   "line_type",        limit: 30,                     null: false
    t.decimal  "price",                        default: "0.0"
    t.string   "price_curr",       limit: 255
    t.string   "status",           limit: 255, default: "active", null: false
    t.text     "notes"
    t.integer  "user_id",                                         null: false
    t.integer  "patron_id",                                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "finitem_id"
    t.integer  "unit_number",                  default: 1
    t.string   "unit_type",        limit: 30
    t.decimal  "unit_price",                   default: "0.0"
    t.decimal  "total_amount",                 default: "0.0"
    t.decimal  "discount_rate",                default: "0.0"
    t.decimal  "discount_amount",              default: "0.0"
    t.integer  "vat_id"
    t.decimal  "vat_rate",                     default: "0.0"
    t.decimal  "vat_amount",                   default: "0.0"
    t.integer  "account_id"
    t.string   "load_place"
    t.string   "unload_place"
    t.integer  "load_custom_id"
    t.integer  "unload_custom_id"
    t.string   "weight_notes"
    t.string   "line_operation"
    t.string   "dep_place_type",   limit: 10
    t.string   "dep_place",        limit: 60
    t.integer  "dep_place_id"
    t.string   "dep_city",         limit: 60
    t.string   "dep_country_id",   limit: 2
    t.integer  "dep_zipcode"
    t.string   "arv_place_type",   limit: 10
    t.string   "arv_place",        limit: 60
    t.integer  "arv_place_id"
    t.string   "arv_city",         limit: 60
    t.string   "arv_country_id",   limit: 2
    t.string   "arv_zipcode"
    t.integer  "dep_city_id"
    t.integer  "arv_city_id"
    t.index ["arv_city_id"], name: "index_logistics_leadlines_on_arv_city_id", using: :btree
    t.index ["dep_city_id"], name: "index_logistics_leadlines_on_dep_city_id", using: :btree
    t.index ["lead_id"], name: "index_logistics_leadlines_on_lead_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_leadlines_on_patron_id", using: :btree
  end

  create_table "logistics_leads", force: :cascade do |t|
    t.string   "reference",       limit: 30,                      null: false
    t.string   "title",           limit: 255
    t.date     "lead_date",                                       null: false
    t.integer  "company_id",                                      null: false
    t.date     "due_date",                                        null: false
    t.decimal  "lead_price",                  default: "0.0"
    t.string   "price_curr",      limit: 3
    t.string   "status",          limit: 10,  default: "pending", null: false
    t.text     "notes"
    t.text     "conditions"
    t.integer  "user_id",                                         null: false
    t.integer  "branch_id",                                       null: false
    t.integer  "patron_id",                                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loadings_count",              default: 0
    t.integer  "documents_count",             default: 0
    t.integer  "comments_count",              default: 0
    t.integer  "leadlines_count",             default: 0
    t.boolean  "is_template",                 default: false
    t.boolean  "trashed",                     default: false
    t.string   "lead_type",       limit: 1
    t.string   "local_curr",      limit: 3
    t.string   "tax_status",      limit: 1
    t.string   "ext_reference",   limit: 100
    t.integer  "template_id"
    t.decimal  "curr_rate",                   default: "1.0",     null: false
    t.decimal  "total_amount",                default: "0.0",     null: false
    t.decimal  "taxfree_amount",              default: "0.0"
    t.decimal  "taxed_amount",                default: "0.0"
    t.decimal  "tax_amount",                  default: "0.0"
    t.decimal  "discount_amount",             default: "0.0"
    t.string   "load_coun",       limit: 2
    t.string   "unload_coun",     limit: 2
    t.integer  "contact_id"
    t.string   "incoterm",        limit: 3
    t.string   "denial_code",     limit: 30
    t.string   "denial_notes"
    t.string   "lead_operation",  limit: 70
    t.float    "total_weight",                default: 0.0
    t.float    "total_volume",                default: 0.0
    t.float    "ladameter",                   default: 0.0
    t.integer  "opportunity_id"
    t.string   "load_type",       limit: 20
    t.string   "lead_class"
    t.integer  "due_day",                     default: 0
    t.index ["branch_id"], name: "index_logistics_leads_on_branch_id", using: :btree
    t.index ["company_id"], name: "index_logistics_leads_on_company_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_leads_on_patron_id", using: :btree
  end

  create_table "logistics_leadtexts", force: :cascade do |t|
    t.integer  "lead_id",              null: false
    t.string   "language",   limit: 2
    t.text     "header"
    t.text     "content"
    t.text     "footer"
    t.text     "conditions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["lead_id"], name: "index_logistics_leadtexts_on_lead_id", using: :btree
  end

  create_table "logistics_loadings", force: :cascade do |t|
    t.string   "reference",               limit: 30,                       null: false
    t.integer  "position_id"
    t.string   "incoterm",                limit: 20
    t.string   "paid_at",                 limit: 20
    t.string   "channel",                 limit: 30
    t.string   "load_type",               limit: 1
    t.integer  "branch_id",                                                null: false
    t.integer  "company_id",                                               null: false
    t.integer  "agent_id"
    t.integer  "user_id",                                                  null: false
    t.integer  "saler_id"
    t.decimal  "freight_price",                        default: "0.0"
    t.string   "freight_curr",            limit: 5
    t.decimal  "agent_price",                          default: "0.0"
    t.string   "agent_curr",              limit: 255
    t.float    "agent_share"
    t.decimal  "product_price",                        default: "0.0"
    t.string   "product_curr",            limit: 255
    t.string   "slug",                    limit: 40
    t.boolean  "bank_flag"
    t.string   "bank",                    limit: 100
    t.string   "producer",                limit: 60
    t.string   "marks_nos",               limit: 50
    t.string   "hts_no",                  limit: 20
    t.float    "brut_wg",                              default: 0.0
    t.float    "volume"
    t.float    "ladameter"
    t.float    "price_wg"
    t.string   "weight_unit",             limit: 20
    t.integer  "patron_id",                                                null: false
    t.boolean  "trashed",                              default: false
    t.text     "commodity"
    t.text     "notes"
    t.string   "load_coun",               limit: 2
    t.string   "unload_coun",             limit: 2
    t.string   "status",                  limit: 10,   default: "active"
    t.string   "sender_name",             limit: 255
    t.string   "consignee_name",          limit: 255
    t.string   "category",                limit: 60
    t.integer  "departures_count",                     default: 0
    t.integer  "arrivals_count",                       default: 0
    t.integer  "containers_count",                     default: 0
    t.integer  "packages_count",                       default: 0
    t.integer  "documents_count",                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lead_id"
    t.string   "customer_ref",            limit: 40
    t.string   "agent_ref",               limit: 40
    t.string   "color",                   limit: 10
    t.integer  "import_id"
    t.string   "container_nos",           limit: 1000
    t.integer  "sender_id"
    t.integer  "consignee_id"
    t.string   "load_place",              limit: 1000
    t.string   "load_place_gmaps_id",     limit: 255
    t.string   "unload_place",            limit: 1000
    t.string   "unload_place_gmaps_id",   limit: 255
    t.date     "load_date"
    t.float    "dep_lat"
    t.float    "dep_lng"
    t.float    "arv_lat"
    t.float    "arv_lng"
    t.date     "unload_date"
    t.integer  "load_custom_id"
    t.integer  "load_customofficer_id"
    t.integer  "unload_custom_id"
    t.integer  "unload_customofficer_id"
    t.integer  "contact_id"
    t.integer  "gtip_id"
    t.string   "extref",                  limit: 20
    t.integer  "operation_id"
    t.integer  "source_id"
    t.string   "source_type",             limit: 255
    t.string   "vagon_no",                limit: 100
    t.string   "dep_zipcode",             limit: 40
    t.string   "arv_zipcode",             limit: 40
    t.integer  "load_city_id"
    t.integer  "unload_city_id"
    t.integer  "operator_id"
    t.string   "border_gate"
    t.date     "border_date"
    t.string   "customs_type",            limit: 40
    t.integer  "notify1_id"
    t.integer  "notify2_id"
    t.integer  "delivery_id"
    t.boolean  "vesaik_mukabili"
    t.integer  "termin_days",                          default: 0
    t.date     "termin_date"
    t.string   "ppcc",                    limit: 2
    t.decimal  "estimated_debit",                      default: "0.0"
    t.decimal  "estimated_credit",                     default: "0.0"
    t.decimal  "invoiced_debit",                       default: "0.0"
    t.decimal  "invoiced_credit",                      default: "0.0"
    t.string   "addr_unno",               limit: 30
    t.integer  "teu",                                  default: 0
    t.string   "cmr_status",              limit: 10,   default: "pending"
    t.string   "uuid",                    limit: 100
    t.integer  "manifesto_id"
    t.string   "gtip_code",               limit: 20
    t.string   "invoice_status",          limit: 10
    t.string   "notification_status",     limit: 10
    t.string   "debit_invoice_nos",       limit: 255
    t.string   "credit_invoice_nos",      limit: 255
    t.integer  "sender_place_id"
    t.integer  "consignee_place_id"
    t.string   "commodity_type",          limit: 20,   default: "other"
    t.string   "ecmr_id",                 limit: 10
    t.string   "ecmr_reference",          limit: 100
    t.string   "ecmr_status",             limit: 30
    t.integer  "project_id"
    t.index ["branch_id"], name: "index_logistics_loadings_on_branch_id", using: :btree
    t.index ["company_id"], name: "index_logistics_loadings_on_company_id", using: :btree
    t.index ["load_city_id"], name: "index_logistics_loadings_on_load_city_id", using: :btree
    t.index ["load_coun"], name: "index_logistics_loadings_on_load_coun", using: :btree
    t.index ["patron_id", "branch_id"], name: "index_logistics_loadings_on_patron_id_and_branch_id", using: :btree
    t.index ["patron_id", "company_id"], name: "index_logistics_loadings_on_patron_id_and_company_id", using: :btree
    t.index ["patron_id", "position_id"], name: "index_logistics_loadings_on_patron_id_and_position_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_loadings_on_patron_id", using: :btree
    t.index ["project_id"], name: "index_logistics_loadings_on_project_id", using: :btree
    t.index ["reference", "patron_id"], name: "index_logistics_loadings_on_reference_and_patron_id", unique: true, using: :btree
    t.index ["unload_city_id"], name: "index_logistics_loadings_on_unload_city_id", using: :btree
    t.index ["unload_coun"], name: "index_logistics_loadings_on_unload_coun", using: :btree
  end

  create_table "logistics_operations", force: :cascade do |t|
    t.string   "code",                     limit: 30
    t.string   "name",                     limit: 100
    t.string   "trans_method",             limit: 30
    t.integer  "user_id"
    t.integer  "patron_id"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "trans_type",               limit: 10
    t.string   "profit_center_code",       limit: 100
    t.string   "ledger_account_code",      limit: 100
    t.string   "engine",                   limit: 20
    t.integer  "finitem_id"
    t.string   "counter_type",             limit: 10,  default: "shared", null: false
    t.string   "profit_line_code",         limit: 50
    t.integer  "loading_counter_id"
    t.integer  "position_counter_id"
    t.string   "invoice_control_type",     limit: 30
    t.string   "report_group",             limit: 50
    t.boolean  "map_integration"
    t.boolean  "position_loading_confirm"
    t.index ["loading_counter_id"], name: "index_logistics_operations_on_loading_counter_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_operations_on_patron_id", using: :btree
    t.index ["position_counter_id"], name: "index_logistics_operations_on_position_counter_id", using: :btree
  end

  create_table "logistics_packages", force: :cascade do |t|
    t.integer  "loading_id"
    t.string   "pack_type",      limit: 255,                 null: false
    t.integer  "total",                      default: 0
    t.float    "brutwg",                     default: 0.0
    t.float    "netwg",                      default: 0.0
    t.float    "volume",                     default: 0.0
    t.float    "lada",                       default: 0.0
    t.string   "weight_unit",    limit: 20
    t.string   "imo",            limit: 20
    t.string   "gtip",           limit: 20
    t.string   "po",             limit: 20
    t.string   "container_no",   limit: 40
    t.integer  "patron_id",                                  null: false
    t.boolean  "trashed",                    default: false
    t.text     "description"
    t.text     "loading_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "dimension",      limit: 255
    t.integer  "leadline_id"
    t.integer  "dimension1"
    t.integer  "dimension2"
    t.integer  "dimension3"
    t.string   "dim_unit",       limit: 20
    t.string   "dimension_unit", limit: 20
    t.decimal  "inner_quantity"
    t.integer  "lead_id"
    t.integer  "container_id"
    t.string   "gtip_code",      limit: 20
    t.index ["container_id"], name: "index_logistics_packages_on_container_id", using: :btree
    t.index ["lead_id"], name: "index_logistics_packages_on_lead_id", using: :btree
    t.index ["loading_id", "patron_id"], name: "index_logistics_packages_on_loading_id_and_patron_id", using: :btree
    t.index ["loading_id"], name: "index_logistics_packages_on_loading_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_packages_on_patron_id", using: :btree
  end

  create_table "logistics_places", force: :cascade do |t|
    t.string   "code",             limit: 100
    t.string   "name",             limit: 255,                                             null: false
    t.string   "place_type",       limit: 10,                                              null: false
    t.string   "address",          limit: 255
    t.string   "city_name",        limit: 100
    t.string   "country_id",       limit: 2
    t.integer  "patron_id"
    t.decimal  "lat",                          precision: 10, scale: 6
    t.decimal  "lng",                          precision: 10, scale: 6
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.string   "gmaps_id",         limit: 255
    t.string   "gmaps_title",      limit: 255
    t.string   "website",          limit: 100
    t.string   "email",            limit: 100
    t.text     "notes"
    t.string   "local_name",       limit: 100
    t.string   "w3w",              limit: 100
    t.integer  "company_id"
    t.integer  "city_id"
    t.string   "tel"
    t.string   "opening_info"
    t.string   "office_roles"
    t.string   "border_countries"
    t.string   "status",                                                default: "active"
    t.string   "post_code",        limit: 255
    t.index ["country_id"], name: "index_logistics_places_on_country_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_places_on_patron_id", using: :btree
    t.index ["place_type"], name: "index_logistics_places_on_place_type", using: :btree
  end

  create_table "logistics_points", force: :cascade do |t|
    t.string  "place_type",  limit: 10
    t.string  "parent_type"
    t.integer "parent_id"
    t.string  "country_id",  limit: 2
    t.integer "state_id"
    t.string  "state_name",  limit: 100
    t.integer "city_id"
    t.string  "city_name",   limit: 100
    t.string  "district",    limit: 100
    t.string  "postcode",    limit: 200
    t.string  "address",     limit: 250
    t.float   "longitude"
    t.float   "latitude"
    t.string  "w3w_code"
    t.integer "place_id"
    t.integer "user_id"
    t.index ["parent_type", "parent_id"], name: "index_logistics_points_on_parent_type_and_parent_id", using: :btree
    t.index ["user_id"], name: "index_logistics_points_on_user_id", using: :btree
  end

  create_table "logistics_positions", force: :cascade do |t|
    t.string   "reference",           limit: 30,                      null: false
    t.string   "title",               limit: 255
    t.integer  "branch_id",                                           null: false
    t.integer  "user_id",                                             null: false
    t.string   "status",              limit: 10,  default: "pending"
    t.date     "report_date"
    t.string   "slug",                limit: 40
    t.boolean  "trashed",                         default: false
    t.text     "notes"
    t.integer  "patron_id",                                           null: false
    t.integer  "loadings_count",                  default: 0
    t.integer  "transports_count",                default: 0
    t.integer  "documents_count",                 default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lead_id"
    t.integer  "comments_count",                  default: 0
    t.string   "trans_method",        limit: 20
    t.string   "trans_type",          limit: 20
    t.string   "vessel_code",         limit: 70
    t.string   "truck_code",          limit: 70
    t.string   "voyage",              limit: 70
    t.string   "vagon"
    t.string   "waybill_no",          limit: 40
    t.date     "waybill_date"
    t.string   "driver_name",         limit: 60
    t.integer  "owner_id"
    t.integer  "supplier_id"
    t.integer  "agent_id"
    t.datetime "departure_date"
    t.string   "departure_hour",      limit: 5
    t.string   "dep_place_type",      limit: 10
    t.string   "dep_place_name",      limit: 60
    t.string   "dep_city_name",       limit: 60
    t.string   "dep_country_id",      limit: 2
    t.integer  "dep_place_id"
    t.integer  "dep_odemeter",                    default: 0
    t.datetime "arrival_date"
    t.string   "arrival_hour",        limit: 5
    t.string   "arv_place_type",      limit: 10
    t.string   "arv_place_name",      limit: 60
    t.string   "arv_city_name",       limit: 60
    t.string   "arv_country_id",      limit: 2
    t.integer  "arv_place_id"
    t.integer  "arv_odemeter",                    default: 0
    t.decimal  "freight_price",                   default: "0.0"
    t.string   "freight_curr",        limit: 5
    t.string   "extref",              limit: 40
    t.string   "agent_ref",           limit: 40
    t.string   "color",               limit: 10
    t.string   "contract_type",       limit: 10
    t.integer  "driver_id"
    t.string   "driver_tel",          limit: 20
    t.string   "truck_type",          limit: 20
    t.string   "route_notes",         limit: 255
    t.datetime "order_date"
    t.datetime "loading_date"
    t.datetime "unloading_date"
    t.integer  "import_id"
    t.integer  "agreement_id"
    t.datetime "assigned_date"
    t.datetime "deadline_date"
    t.date     "border_date"
    t.integer  "operation_id"
    t.integer  "route_id"
    t.string   "border_gate",         limit: 255
    t.integer  "operator_id"
    t.integer  "vessel_id"
    t.integer  "truck_id"
    t.string   "customs_type",        limit: 40
    t.string   "waybill_type",        limit: 30
    t.decimal  "freight_price_rate",              default: "0.0"
    t.string   "cargo_manifest_no",   limit: 100
    t.date     "cargo_manifest_date"
    t.integer  "arrival_vessel_id"
    t.string   "arrival_vessel_code", limit: 100
    t.boolean  "empty_truck",                     default: false
    t.string   "ppcc",                limit: 2
    t.integer  "transit_point1_id"
    t.integer  "transit_point2_id"
    t.integer  "transit_point3_id"
    t.integer  "transit_point4_id"
    t.integer  "transit_point5_id"
    t.integer  "transit_point6_id"
    t.date     "transit_date1"
    t.date     "transit_date2"
    t.date     "transit_date3"
    t.date     "transit_date4"
    t.date     "transit_date5"
    t.date     "transit_date6"
    t.string   "transit_code1",       limit: 50
    t.string   "transit_code2",       limit: 50
    t.string   "transit_code3",       limit: 50
    t.string   "transit_code4",       limit: 50
    t.string   "transit_code5",       limit: 50
    t.string   "transit_code6",       limit: 50
    t.decimal  "estimated_debit",                 default: "0.0"
    t.decimal  "estimated_credit",                default: "0.0"
    t.decimal  "invoiced_debit",                  default: "0.0"
    t.decimal  "invoiced_credit",                 default: "0.0"
    t.integer  "dep_city_id"
    t.integer  "arv_city_id"
    t.string   "uuid",                limit: 100
    t.decimal  "total_fuel",                      default: "0.0"
    t.decimal  "driver_payment",                  default: "0.0"
    t.decimal  "depreciation",                    default: "0.0"
    t.decimal  "commission",                      default: "0.0"
    t.decimal  "route_km",                        default: "0.0"
    t.integer  "project_id"
    t.integer  "untransit_point1_id"
    t.integer  "untransit_point2_id"
    t.integer  "untransit_point3_id"
    t.integer  "untransit_point4_id"
    t.integer  "untransit_point5_id"
    t.integer  "untransit_point6_id"
    t.index ["branch_id"], name: "index_logistics_positions_on_branch_id", using: :btree
    t.index ["departure_date"], name: "index_logistics_positions_on_departure_date", using: :btree
    t.index ["operation_id"], name: "index_logistics_positions_on_operation_id", using: :btree
    t.index ["patron_id", "branch_id"], name: "index_logistics_positions_on_patron_id_and_branch_id", using: :btree
    t.index ["patron_id", "user_id"], name: "index_logistics_positions_on_patron_id_and_user_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_positions_on_patron_id", using: :btree
    t.index ["project_id"], name: "index_logistics_positions_on_project_id", using: :btree
    t.index ["route_id"], name: "index_logistics_positions_on_route_id", using: :btree
    t.index ["trans_method"], name: "index_logistics_positions_on_trans_method", using: :btree
    t.index ["transit_point1_id"], name: "index_logistics_positions_on_transit_point1_id", using: :btree
    t.index ["transit_point2_id"], name: "index_logistics_positions_on_transit_point2_id", using: :btree
    t.index ["transit_point3_id"], name: "index_logistics_positions_on_transit_point3_id", using: :btree
    t.index ["transit_point4_id"], name: "index_logistics_positions_on_transit_point4_id", using: :btree
    t.index ["transit_point5_id"], name: "index_logistics_positions_on_transit_point5_id", using: :btree
    t.index ["transit_point6_id"], name: "index_logistics_positions_on_transit_point6_id", using: :btree
    t.index ["truck_code"], name: "index_logistics_positions_on_truck_code", using: :btree
    t.index ["vessel_code"], name: "index_logistics_positions_on_vessel_code", using: :btree
    t.index ["voyage"], name: "index_logistics_positions_on_voyage", using: :btree
  end

  create_table "logistics_rorotrucks", force: :cascade do |t|
    t.integer  "transport_id"
    t.integer  "voyage_id"
    t.string   "trailer_code", limit: 30,                 null: false
    t.integer  "trailer_id"
    t.string   "truck_code",   limit: 30
    t.integer  "truck_id"
    t.string   "ticket_no",    limit: 30
    t.date     "ticket_date"
    t.decimal  "ticket_price",            default: "0.0"
    t.string   "ticket_curr",  limit: 3
    t.integer  "patron_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_position",            default: false
    t.index ["patron_id"], name: "index_logistics_rorotrucks_on_patron_id", using: :btree
    t.index ["transport_id"], name: "index_logistics_rorotrucks_on_transport_id", using: :btree
  end

  create_table "logistics_routes", force: :cascade do |t|
    t.string   "title",           limit: 100,                 null: false
    t.integer  "patron_id",                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_codes"
    t.string   "route_countries"
    t.string   "trans_method",    limit: 20
    t.integer  "trans_days"
    t.integer  "trans_km"
    t.boolean  "bridge",                      default: false
    t.boolean  "roro",                        default: false
    t.boolean  "train",                       default: false
    t.boolean  "danger_vehicle",              default: false
    t.integer  "tonaj"
    t.string   "border"
    t.integer  "company_id"
    t.integer  "vat_id"
    t.string   "country_id",      limit: 20
    t.float    "prim_amount"
    t.index ["patron_id"], name: "index_logistics_routes_on_patron_id", using: :btree
  end

  create_table "logistics_ships", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "company_id"
    t.string   "imo_no",       limit: 100
    t.string   "flag_country", limit: 2
    t.integer  "build_year"
    t.string   "teu",          limit: 100
    t.string   "body_type",    limit: 100
    t.text     "notes"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "logistics_tariff_custom_barems", force: :cascade do |t|
    t.integer  "tariffline_id"
    t.decimal  "unit",          default: "0.0"
    t.decimal  "rate1",         default: "0.0"
    t.decimal  "rate2",         default: "0.0"
    t.decimal  "rate3",         default: "0.0"
    t.decimal  "rate4",         default: "0.0"
    t.decimal  "rate5",         default: "0.0"
    t.decimal  "rate6",         default: "0.0"
    t.decimal  "rate7",         default: "0.0"
    t.decimal  "rate8",         default: "0.0"
    t.decimal  "rate9",         default: "0.0"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["tariffline_id"], name: "index_logistics_tariff_custom_barems_on_tariffline_id", using: :btree
  end

  create_table "logistics_tariff_custom_lines", force: :cascade do |t|
    t.integer  "tariffline_id"
    t.integer  "sender_id"
    t.integer  "consignee_id"
    t.string   "gtip_code",              limit: 50
    t.string   "gtip_group"
    t.integer  "load_custom_id"
    t.integer  "unload_custom_id"
    t.string   "load_country_id",        limit: 2
    t.string   "unload_country_id",      limit: 2
    t.integer  "manifesto_duration"
    t.string   "doc_type",               limit: 20
    t.string   "load_custom_district"
    t.string   "unload_custom_district"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "supplier_id"
    t.string   "line_type"
    t.string   "notes"
    t.decimal  "fine_price",                        default: "0.0"
    t.integer  "next_days",                         default: 0
    t.index ["tariffline_id"], name: "index_logistics_tariff_custom_lines_on_tariffline_id", using: :btree
  end

  create_table "logistics_tariff_full_prices", force: :cascade do |t|
    t.integer  "tariffline_id"
    t.string   "vehicle_type"
    t.decimal  "full_price",    default: "0.0"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["tariffline_id"], name: "index_logistics_tariff_full_prices_on_tariffline_id", using: :btree
  end

  create_table "logistics_tariff_partial_prices", force: :cascade do |t|
    t.integer  "tariffline_id"
    t.integer  "unit"
    t.float    "rate"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["tariffline_id"], name: "index_logistics_tariff_partial_prices_on_tariffline_id", using: :btree
  end

  create_table "logistics_tariff_transport_lines", force: :cascade do |t|
    t.integer  "tariffline_id"
    t.integer  "dep_country_id"
    t.string   "dep_city_name"
    t.string   "dep_place_name"
    t.integer  "dep_place_id"
    t.string   "dep_postcode",   limit: 20
    t.string   "dep_w3w"
    t.integer  "arv_country_id"
    t.string   "arv_city_name"
    t.string   "arv_place_name"
    t.integer  "arv_place_id"
    t.string   "arv_postcode",   limit: 20
    t.string   "arv_w3w"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["tariffline_id"], name: "index_logistics_tariff_transport_lines_on_tariffline_id", using: :btree
  end

  create_table "logistics_tarifflines", force: :cascade do |t|
    t.integer  "tariff_id"
    t.decimal  "min_price",                 default: "0.0"
    t.integer  "patron_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "status"
    t.text     "notes"
    t.string   "curr",           limit: 3
    t.integer  "dep_country_id"
    t.integer  "dep_city_id"
    t.string   "dep_place_name"
    t.integer  "dep_place_id"
    t.string   "dep_postcode",   limit: 20
    t.string   "dep_w3w"
    t.integer  "arv_country_id"
    t.integer  "arv_city_id"
    t.string   "arv_place_name"
    t.integer  "arv_place_id"
    t.string   "arv_postcode",   limit: 20
    t.string   "arv_w3w"
    t.string   "tariff_type",    limit: 20
    t.index ["tariff_id"], name: "index_logistics_tarifflines_on_tariff_id", using: :btree
  end

  create_table "logistics_tariffs", force: :cascade do |t|
    t.string   "title",                 limit: 255,                    null: false
    t.date     "tariff_date"
    t.date     "due_date"
    t.integer  "user_id",                                              null: false
    t.integer  "patron_id",                                            null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "curr",                  limit: 3
    t.string   "status",                limit: 20,  default: "active"
    t.string   "tariff_type",           limit: 20,  default: "sales"
    t.string   "debit_credit",          limit: 10
    t.integer  "supplier_id"
    t.boolean  "partial_prices"
    t.boolean  "full_container_prices"
    t.boolean  "full_truck_prices"
    t.string   "unit_scales"
    t.string   "vehicle_type"
    t.integer  "agent_id"
    t.string   "tariff_species",        limit: 20
    t.index ["patron_id"], name: "index_logistics_tariffs_on_patron_id", using: :btree
  end

  create_table "logistics_transports", force: :cascade do |t|
    t.integer  "position_id"
    t.string   "trans_method",          limit: 20,                     null: false
    t.string   "vessel",                limit: 70
    t.string   "truck",                 limit: 70
    t.string   "voyage",                limit: 70
    t.string   "vagon",                 limit: 255
    t.string   "waybill_no",            limit: 40
    t.date     "waybill_date"
    t.string   "driver_name",           limit: 60
    t.integer  "driver_id"
    t.integer  "owner_id"
    t.integer  "supplier_id"
    t.integer  "branch_id"
    t.integer  "user_id",                                              null: false
    t.integer  "patron_id",                                            null: false
    t.date     "departure_date"
    t.string   "departure_hour",        limit: 5
    t.string   "dep_place_type",        limit: 10
    t.string   "dep_place",             limit: 200
    t.string   "dep_city_name",         limit: 60
    t.string   "dep_country_id",        limit: 2
    t.date     "arrival_date"
    t.string   "arrival_hour",          limit: 5
    t.string   "arv_place_type",        limit: 10
    t.string   "arv_place",             limit: 200
    t.string   "arv_city_name",         limit: 60
    t.string   "arv_country_id",        limit: 2
    t.decimal  "freight_price",                     default: "0.0"
    t.string   "freight_curr",          limit: 5
    t.text     "notes"
    t.string   "status",                limit: 10,  default: "active"
    t.boolean  "trashed",                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                    default: 0
    t.string   "contract_type",         limit: 10
    t.integer  "loading_id"
    t.string   "trans_type",            limit: 20
    t.string   "loaded_units",          limit: 255
    t.string   "empty_container_place", limit: 255
    t.date     "border_date"
    t.string   "customs_type",          limit: 30
    t.integer  "operator_id"
    t.integer  "operation_id"
    t.integer  "load_sequence",                     default: 1
    t.integer  "unload_sequence",                   default: 1
    t.integer  "dep_city_id"
    t.integer  "arv_city_id"
    t.datetime "unload_date"
    t.string   "unload_reason",         limit: 255
    t.string   "uuid",                  limit: 100
    t.index ["branch_id"], name: "index_logistics_transports_on_branch_id", using: :btree
    t.index ["loading_id"], name: "index_logistics_transports_on_loading_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_transports_on_patron_id", using: :btree
    t.index ["position_id"], name: "index_logistics_transports_on_position_id", using: :btree
    t.index ["trans_method"], name: "index_logistics_transports_on_trans_method", using: :btree
    t.index ["truck"], name: "index_logistics_transports_on_truck", using: :btree
    t.index ["vessel"], name: "index_logistics_transports_on_vessel", using: :btree
    t.index ["voyage"], name: "index_logistics_transports_on_voyage", using: :btree
  end

  create_table "logistics_transroutes", force: :cascade do |t|
    t.string   "route_type",     limit: 20,                 null: false
    t.string   "route_name",     limit: 60,                 null: false
    t.string   "route_city",     limit: 50
    t.string   "route_country",  limit: 2,                  null: false
    t.date     "arrival_date"
    t.date     "departure_date"
    t.integer  "transport_id",                              null: false
    t.integer  "route_id"
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "gmaps"
    t.integer  "patron_id",                                 null: false
    t.boolean  "trashed",                   default: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["patron_id", "route_id"], name: "index_logistics_transroutes_on_patron_id_and_route_id", using: :btree
    t.index ["transport_id"], name: "index_logistics_transroutes_on_transport_id", using: :btree
  end

  create_table "logistics_voyage_positions", force: :cascade do |t|
    t.integer  "voyage_id"
    t.integer  "position_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "logistics_voyageports", force: :cascade do |t|
    t.integer  "voyage_id",                        null: false
    t.string   "parent_type",                      null: false
    t.integer  "parent_id",                        null: false
    t.integer  "departure_place_id"
    t.string   "departure_country_id", limit: 2
    t.string   "departure_place_name", limit: 500
    t.integer  "arrival_place_id"
    t.string   "arrival_country_id",   limit: 2
    t.string   "arrival_place_name",   limit: 500
    t.text     "notes"
    t.integer  "user_id",                          null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["arrival_place_id"], name: "index_logistics_voyageports_on_arrival_place_id", using: :btree
    t.index ["departure_place_id"], name: "index_logistics_voyageports_on_departure_place_id", using: :btree
    t.index ["parent_type", "parent_id"], name: "index_logistics_voyageports_on_parent_type_and_parent_id", using: :btree
    t.index ["user_id"], name: "index_logistics_voyageports_on_user_id", using: :btree
    t.index ["voyage_id"], name: "index_logistics_voyageports_on_voyage_id", using: :btree
  end

  create_table "logistics_voyages", force: :cascade do |t|
    t.string   "reference",                                           null: false
    t.integer  "patron_id",                                           null: false
    t.integer  "user_id",                                             null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "trans_method",                                        null: false
    t.date     "start_date"
    t.date     "finish_date"
    t.string   "voyage_type",        limit: 20
    t.integer  "vehicle_id"
    t.integer  "trailer_id"
    t.integer  "driver_id"
    t.integer  "departure_route_id"
    t.integer  "arrival_route_id"
    t.integer  "vehicle_start_km"
    t.integer  "vehicle_finish_km"
    t.float    "fuel_rate"
    t.string   "departure_doc_type", limit: 20
    t.string   "departure_doc_no",   limit: 100
    t.string   "arrival_doc_type",   limit: 20
    t.string   "arrival_doc_no",     limit: 100
    t.string   "status",             limit: 20,  default: "planning", null: false
    t.integer  "branch_id"
    t.string   "voyage_no"
    t.string   "vessel"
    t.integer  "owner_id"
    t.integer  "supplier_id"
    t.string   "waybill_no"
    t.string   "waybill_date"
    t.string   "dep_place_name",     limit: 60
    t.string   "dep_city_name",      limit: 60
    t.string   "dep_country_id",     limit: 2
    t.integer  "dep_place_id"
    t.string   "arv_place_name",     limit: 60
    t.string   "arv_city_name",      limit: 60
    t.string   "arv_country_id",     limit: 2
    t.integer  "arv_place_id"
    t.boolean  "trashed",                        default: false
    t.integer  "operator_id"
    t.integer  "operation_id"
    t.string   "remote_id"
    t.text     "notes"
    t.integer  "dep_city_id"
    t.integer  "arv_city_id"
    t.string   "voyage_status",      limit: 20
    t.string   "vehicle_code",       limit: 30
    t.string   "trailer_code",       limit: 30
    t.string   "driver_name",        limit: 100
    t.string   "driver_tel",         limit: 30
    t.string   "contract_type",      limit: 30
    t.index ["arrival_route_id"], name: "index_logistics_voyages_on_arrival_route_id", using: :btree
    t.index ["branch_id"], name: "index_logistics_voyages_on_branch_id", using: :btree
    t.index ["departure_route_id"], name: "index_logistics_voyages_on_departure_route_id", using: :btree
    t.index ["driver_id"], name: "index_logistics_voyages_on_driver_id", using: :btree
    t.index ["trailer_id"], name: "index_logistics_voyages_on_trailer_id", using: :btree
    t.index ["vehicle_id"], name: "index_logistics_voyages_on_vehicle_id", using: :btree
  end

  create_table "logistics_wagons", force: :cascade do |t|
    t.string   "code",             limit: 40,               null: false
    t.float    "weight",                      default: 0.0
    t.integer  "transport_id",                              null: false
    t.string   "containers"
    t.date     "arrival_date"
    t.integer  "user_id",                                   null: false
    t.integer  "patron_id",                                 null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "order_no",         limit: 2
    t.string   "status",           limit: 10
    t.text     "notes"
    t.integer  "place_id"
    t.integer  "last_position_id"
    t.index ["patron_id"], name: "index_logistics_wagons_on_patron_id", using: :btree
    t.index ["transport_id"], name: "index_logistics_wagons_on_transport_id", using: :btree
  end

  create_table "logistics_waybill_stock_lines", force: :cascade do |t|
    t.integer "waybill_stock_id",                               null: false
    t.string  "code",             limit: 50,                    null: false
    t.string  "status",           limit: 10, default: "active", null: false
    t.integer "position_id"
    t.integer "agreement_id"
    t.boolean "trashed",                     default: false
    t.integer "patron_id"
    t.index ["agreement_id"], name: "index_logistics_waybill_stock_lines_on_agreement_id", using: :btree
    t.index ["position_id"], name: "index_logistics_waybill_stock_lines_on_position_id", using: :btree
    t.index ["waybill_stock_id"], name: "index_logistics_waybill_stock_lines_on_waybill_stock_id", using: :btree
  end

  create_table "logistics_waybill_stocks", force: :cascade do |t|
    t.date     "stock_date",                 null: false
    t.integer  "airline_id",                 null: false
    t.integer  "supplier_id"
    t.string   "start_no",                   null: false
    t.string   "finish_no",                  null: false
    t.integer  "user_id",                    null: false
    t.integer  "patron_id",                  null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "comments_count", default: 0
    t.integer  "branch_id"
    t.index ["airline_id"], name: "index_logistics_waybill_stocks_on_airline_id", using: :btree
    t.index ["patron_id"], name: "index_logistics_waybill_stocks_on_patron_id", using: :btree
    t.index ["supplier_id"], name: "index_logistics_waybill_stocks_on_supplier_id", using: :btree
  end

  create_table "messenger_email_attachments", force: :cascade do |t|
    t.integer  "email_id",                   null: false
    t.string   "attached_file", limit: 1000
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "name",          limit: 255
    t.index ["email_id"], name: "index_messenger_email_attachments_on_email_id", using: :btree
  end

  create_table "messenger_email_blocks", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "img"
    t.integer  "order_no"
    t.integer  "email_template_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "messenger_email_receivers", force: :cascade do |t|
    t.string   "to"
    t.string   "cc"
    t.integer  "patron_id",         null: false
    t.integer  "user_id",           null: false
    t.integer  "email_template_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["email_template_id"], name: "index_messenger_email_receivers_on_email_template_id", using: :btree
    t.index ["patron_id"], name: "index_messenger_email_receivers_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_messenger_email_receivers_on_user_id", using: :btree
  end

  create_table "messenger_email_templates", force: :cascade do |t|
    t.string   "title"
    t.string   "code"
    t.text     "content"
    t.string   "query"
    t.string   "action_url"
    t.string   "data_action_type"
    t.boolean  "following",        default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "notify_code"
  end

  create_table "messenger_emails", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "content"
    t.string   "from",            limit: 255,                    null: false
    t.text     "to",                                             null: false
    t.text     "cc"
    t.text     "bcc"
    t.string   "parent_type",     limit: 255
    t.integer  "parent_id"
    t.string   "token",           limit: 255
    t.integer  "user_id",                                        null: false
    t.integer  "patron_id",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "attachments"
    t.integer  "group_id"
    t.string   "source_type",     limit: 10,  default: "system"
    t.string   "service",         limit: 10
    t.string   "status",          limit: 10,  default: "sent"
    t.string   "error_msg"
    t.boolean  "send_copy_to_me",             default: false
    t.index ["parent_type", "parent_id"], name: "index_messenger_emails_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_messenger_emails_on_patron_id", using: :btree
  end

  create_table "messenger_memos", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "message"
    t.datetime "due_time",                                      null: false
    t.string   "status",         limit: 255, default: "active", null: false
    t.string   "memo_type",      limit: 10,                     null: false
    t.integer  "patron_id"
    t.integer  "user_id",                                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",             default: 0
    t.datetime "start_time"
    t.string   "lang",           limit: 2
    t.string   "memo_scope",     limit: 10
    t.index ["patron_id"], name: "index_messenger_memos_on_patron_id", using: :btree
  end

  create_table "messenger_message_users", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.integer  "message_id",                 null: false
    t.boolean  "is_read",    default: false
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messenger_messages", force: :cascade do |t|
    t.text     "message",                null: false
    t.integer  "sender_id",              null: false
    t.integer  "parent_id"
    t.integer  "patron_id",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "parent_type", limit: 40
    t.index ["patron_id"], name: "index_messenger_messages_on_patron_id", using: :btree
    t.index ["sender_id"], name: "index_messenger_messages_on_sender_id", using: :btree
  end

  create_table "messenger_notification_users", force: :cascade do |t|
    t.integer  "notification_id",                 null: false
    t.integer  "user_id",                         null: false
    t.boolean  "is_read",         default: false
    t.boolean  "is_mailed",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messenger_notifications", force: :cascade do |t|
    t.string   "action_type",          limit: 100, null: false
    t.string   "title",                limit: 255, null: false
    t.integer  "sender_id"
    t.string   "target_type",          limit: 50,  null: false
    t.integer  "target_id",                        null: false
    t.string   "target_url",           limit: 255
    t.string   "notification_channel", limit: 50
    t.integer  "patron_id",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notify_id"
  end

  create_table "messenger_notifies", force: :cascade do |t|
    t.string   "code"
    t.string   "title"
    t.string   "content"
    t.string   "i18n_code"
    t.string   "engine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messenger_notify_users", force: :cascade do |t|
    t.integer "notify_id"
    t.string  "notify_type"
    t.integer "user_id"
    t.integer "patron_id"
    t.index ["notify_id"], name: "index_messenger_notify_users_on_notify_id", using: :btree
    t.index ["patron_id"], name: "index_messenger_notify_users_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_messenger_notify_users_on_user_id", using: :btree
  end

  create_table "messenger_sms_messages", force: :cascade do |t|
    t.string   "sent_from",    limit: 255
    t.text     "sent_to",                  null: false
    t.text     "content",                  null: false
    t.string   "provider",     limit: 30,  null: false
    t.string   "status",       limit: 3
    t.string   "ticket_id",    limit: 100
    t.string   "message_type", limit: 30
    t.integer  "user_id",                  null: false
    t.integer  "patron_id",                null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "group_id"
    t.index ["patron_id"], name: "index_messenger_sms_messages_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_messenger_sms_messages_on_user_id", using: :btree
  end

  create_table "network_bank_notes", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "bank_name",       limit: 50,                    null: false
    t.string   "iban",            limit: 50,                    null: false
    t.string   "curr",            limit: 3,                     null: false
    t.string   "status",                     default: "active", null: false
    t.boolean  "default_account",            default: false
    t.integer  "patron_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["company_id"], name: "index_network_bank_notes_on_company_id", using: :btree
    t.index ["patron_id"], name: "index_network_bank_notes_on_patron_id", using: :btree
  end

  create_table "network_companies", force: :cascade do |t|
    t.string   "name",              limit: 255,                            null: false
    t.string   "title",             limit: 255
    t.string   "company_type",      limit: 10
    t.string   "tel",               limit: 100
    t.string   "fax",               limit: 100
    t.string   "gsm",               limit: 100
    t.string   "voip",              limit: 100
    t.string   "email",             limit: 255
    t.string   "website",           limit: 255
    t.string   "sector",            limit: 40
    t.string   "postcode",          limit: 20
    t.string   "address",           limit: 255
    t.string   "district",          limit: 100
    t.string   "city_name",         limit: 100
    t.string   "state",             limit: 100
    t.string   "country_id",        limit: 2
    t.string   "status",            limit: 10,   default: "active"
    t.integer  "branch_id",                                                null: false
    t.integer  "patron_id",                                                null: false
    t.float    "lat"
    t.float    "lng"
    t.boolean  "gmaps"
    t.text     "notes"
    t.integer  "saler_id"
    t.integer  "user_id",                                                  null: false
    t.string   "company_no",        limit: 50
    t.string   "slug",              limit: 50
    t.integer  "contacts_count",                 default: 0
    t.integer  "events_count",                   default: 0
    t.integer  "partners_count",                 default: 0
    t.integer  "discussions_count",              default: 0
    t.datetime "created_at",                     default: -> { "now()" }
    t.datetime "updated_at",                     default: -> { "now()" }
    t.integer  "documents_count",                default: 0
    t.integer  "notices_count",                  default: 0
    t.string   "eori_code"
    t.string   "taxno",             limit: 20
    t.string   "taxoffice",         limit: 100
    t.date     "last_lead_date"
    t.date     "last_invoice_date"
    t.boolean  "trashed",                        default: false
    t.integer  "parent_company_id"
    t.boolean  "has_export"
    t.string   "export_countries"
    t.string   "export_notes"
    t.boolean  "has_import"
    t.string   "import_countries"
    t.string   "import_notes"
    t.boolean  "has_warehouse"
    t.boolean  "has_depot"
    t.string   "twitter",           limit: 50
    t.string   "facebook",          limit: 255
    t.string   "linkedin",          limit: 255
    t.string   "business_type",     limit: 255
    t.integer  "operator_id"
    t.boolean  "has_domestic"
    t.integer  "city_id"
    t.string   "due_dets",          limit: 1000
    t.string   "curr",              limit: 3
    t.integer  "due_days",                       default: 30
    t.string   "payment_notes",     limit: 255
    t.decimal  "credit_limit"
    t.string   "financial_status",  limit: 60,   default: "active"
    t.string   "financial_notes"
    t.string   "invoice_type",      limit: 20,   default: "print_invoice"
    t.string   "financial_email",   limit: 255
    t.integer  "financor_id"
    t.integer  "finitem_id"
    t.string   "curr_type"
    t.boolean  "debt_email",                     default: false
    t.string   "remind_payment",    limit: 10,   default: "none"
    t.index "patron_id, lower((name)::text)", name: "index_companies_on_lower_name", using: :btree
    t.index ["patron_id"], name: "index_network_companies_on_patron_id", using: :btree
    t.index ["taxno"], name: "index_network_companies_on_taxno", using: :btree
  end

  create_table "network_company_operations", force: :cascade do |t|
    t.integer  "company_id",   null: false
    t.integer  "patron_id",    null: false
    t.integer  "operation_id"
    t.integer  "due_days",     null: false
    t.integer  "curr"
    t.integer  "user_id",      null: false
    t.integer  "operator_id"
    t.integer  "saler_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "network_contacts", force: :cascade do |t|
    t.string   "name",         limit: 50
    t.integer  "company_id"
    t.integer  "user_id",                                  null: false
    t.string   "salutation",   limit: 10
    t.string   "email",        limit: 100
    t.string   "tel",          limit: 30
    t.string   "gsm",          limit: 30
    t.string   "jobtitle",     limit: 100
    t.string   "department",   limit: 60
    t.string   "tel2",         limit: 30
    t.string   "fax",          limit: 30
    t.date     "birthdate"
    t.integer  "patron_id"
    t.string   "twitter",      limit: 50
    t.string   "facebook",     limit: 255
    t.string   "linkedin",     limit: 255
    t.string   "des",          limit: 255
    t.string   "slug",         limit: 60
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar",       limit: 255
    t.string   "instagram",    limit: 100
    t.string   "skype",        limit: 100
    t.boolean  "trashed",                  default: false
    t.integer  "operation_id"
    t.index "lower((name)::text)", name: "index_contacts_on_lower_name", using: :btree
    t.index ["company_id", "user_id"], name: "index_network_contacts_on_company_id_and_user_id", using: :btree
    t.index ["patron_id"], name: "index_network_contacts_on_patron_id", using: :btree
  end

  create_table "network_contractlines", force: :cascade do |t|
    t.integer  "contract_id"
    t.string   "dep_country_id", limit: 2
    t.string   "arv_country_id", limit: 2
    t.integer  "days_count"
    t.text     "notes"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "dep_address",    limit: 100
    t.string   "arv_address",    limit: 100
  end

  create_table "network_contracts", force: :cascade do |t|
    t.integer  "patron_id",                                  null: false
    t.integer  "user_id",                                    null: false
    t.string   "name",           limit: 100
    t.string   "ref_no"
    t.string   "contract_type",  limit: 50
    t.date     "start_date"
    t.date     "finish_date"
    t.string   "status",         limit: 30
    t.text     "notes"
    t.integer  "operation_id"
    t.integer  "company_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.date     "remainder_date"
    t.float    "price",                      default: 0.0
    t.string   "price_curr",     limit: 3
    t.string   "price_type"
    t.jsonb    "user_fields"
    t.string   "contact_name",   limit: 100
    t.string   "contact_email",  limit: 100
    t.string   "contact_tel",    limit: 30
    t.boolean  "trashed",                    default: false
    t.index ["company_id"], name: "index_network_contracts_on_company_id", using: :btree
    t.index ["contract_type"], name: "index_network_contracts_on_contract_type", using: :btree
    t.index ["operation_id"], name: "index_network_contracts_on_operation_id", using: :btree
    t.index ["patron_id"], name: "index_network_contracts_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_network_contracts_on_user_id", using: :btree
  end

  create_table "network_denied_companies", force: :cascade do |t|
    t.string   "name",          limit: 50
    t.string   "country_id",    limit: 2
    t.string   "taxno",         limit: 20
    t.string   "denial_reason"
    t.integer  "user_id"
    t.text     "notes"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["taxno"], name: "index_network_denied_companies_on_taxno", using: :btree
  end

  create_table "network_financials", force: :cascade do |t|
    t.integer  "company_id",                                                null: false
    t.string   "title",               limit: 255,                           null: false
    t.string   "taxno",               limit: 20
    t.string   "taxoffice",           limit: 100
    t.string   "curr",                limit: 3
    t.integer  "due_days"
    t.string   "invoice_language",    limit: 2
    t.string   "payment_notes",       limit: 255
    t.string   "extra_notes",         limit: 255
    t.integer  "user_id",                                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invoice_country_id",  limit: 2
    t.string   "invoice_city",        limit: 50
    t.text     "invoice_address"
    t.integer  "sales_account_id"
    t.integer  "purchase_account_id"
    t.string   "payment_type",        limit: 30
    t.decimal  "global_limit"
    t.string   "financial_status",    limit: 60,  default: "standart"
    t.string   "financial_notes"
    t.string   "invoice_type",        limit: 20,  default: "print_invoice"
    t.string   "email",               limit: 255
    t.string   "bank_name",           limit: 100
    t.string   "iban",                limit: 50
    t.string   "mapping_type",        limit: 50
    t.string   "mapping_parent_type", limit: 50
    t.string   "agreement_status",    limit: 100
    t.string   "invoice_town",        limit: 50
    t.string   "status",              limit: 30,  default: "active"
    t.string   "notes"
    t.integer  "financial_person_id"
    t.integer  "finitem_id"
    t.string   "curr_type"
    t.string   "zipcode"
    t.index ["company_id"], name: "company_can_have_one_financial", unique: true, using: :btree
    t.index ["company_id"], name: "index_network_financials_on_company_id", using: :btree
    t.index ["taxno"], name: "index_network_financials_on_taxno", using: :btree
  end

  create_table "network_notices", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "title",            limit: 255,             null: false
    t.string   "notice_type",      limit: 20,              null: false
    t.date     "notice_date",                              null: false
    t.text     "description"
    t.text     "participants"
    t.integer  "user_id",                                  null: false
    t.integer  "patron_id",                                null: false
    t.integer  "comments_count",               default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "opportunity_id"
    t.string   "our_participants"
    t.date     "remainder_date"
    t.index ["company_id"], name: "index_network_notices_on_company_id", using: :btree
    t.index ["opportunity_id"], name: "index_network_notices_on_opportunity_id", using: :btree
    t.index ["user_id"], name: "index_network_notices_on_user_id", using: :btree
  end

  create_table "network_opportunities", force: :cascade do |t|
    t.string   "company_name"
    t.integer  "company_id"
    t.string   "country_id",       limit: 2
    t.string   "address"
    t.boolean  "has_export"
    t.string   "export_countries"
    t.string   "export_notes"
    t.boolean  "has_import"
    t.string   "import_countries"
    t.string   "import_notes"
    t.boolean  "has_warehouse"
    t.boolean  "has_depot"
    t.text     "notes"
    t.string   "status",                       default: "pending"
    t.boolean  "has_domestic"
    t.string   "contact_name"
    t.string   "contact_email",    limit: 100
    t.string   "contact_tel",      limit: 50
    t.integer  "comments_count",               default: 0
    t.integer  "user_id",                                          null: false
    t.integer  "patron_id",                                        null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "branch_id"
    t.datetime "reminder_time"
    t.string   "website",          limit: 255
    t.string   "twitter",          limit: 50
    t.string   "facebook",         limit: 255
    t.string   "linkedin",         limit: 255
    t.integer  "notices_count",                default: 0
    t.string   "company_type",     limit: 50
    t.string   "business_type",    limit: 255
    t.integer  "operator_id"
    t.string   "city_name"
    t.string   "tel"
    t.string   "operations"
    t.integer  "city_id"
    t.index ["branch_id"], name: "index_network_opportunities_on_branch_id", using: :btree
    t.index ["company_id"], name: "index_network_opportunities_on_company_id", using: :btree
    t.index ["patron_id"], name: "index_network_opportunities_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_network_opportunities_on_user_id", using: :btree
  end

  create_table "network_subscribers", force: :cascade do |t|
    t.string   "email",              limit: 100,                    null: false
    t.string   "name",               limit: 100
    t.string   "source_type",        limit: 30
    t.string   "status",             limit: 10,  default: "active"
    t.string   "parent_type",        limit: 100
    t.integer  "parent_id"
    t.date     "last_mail_date"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "unsubscribe_code",   limit: 30
    t.string   "unsubscribe_reason", limit: 255
    t.date     "unsubscribe_date"
    t.string   "access_token",       limit: 255
  end

  create_table "nimbos_activities", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.string   "target_type", limit: 40
    t.integer  "target_id"
    t.string   "target_name", limit: 60
    t.integer  "patron_id",              null: false
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "patron_id"], name: "index_nimbos_activities_on_user_id_and_patron_id", using: :btree
  end

  create_table "nimbos_auth_proc_patrons", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "auth_proc_id"
    t.integer  "admin_id"
    t.text     "notes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["auth_proc_id"], name: "index_nimbos_auth_proc_patrons_on_auth_proc_id", using: :btree
    t.index ["patron_id", "auth_proc_id"], name: "index_nimbos_auth_proc_patrons_on_patron_id_and_auth_proc_id", unique: true, using: :btree
    t.index ["patron_id"], name: "index_nimbos_auth_proc_patrons_on_patron_id", using: :btree
  end

  create_table "nimbos_auth_procs", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "i18n_code"
    t.string   "engine"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "initial_value", default: true
    t.boolean  "global",        default: false
  end

  create_table "nimbos_authorizations", force: :cascade do |t|
    t.integer  "user_id",                                null: false
    t.string   "controller",   limit: 50,                null: false
    t.boolean  "can_manage",              default: true
    t.boolean  "can_read",                default: true
    t.boolean  "can_create",              default: true
    t.boolean  "can_update",              default: true
    t.boolean  "can_delete",              default: true
    t.boolean  "can_list",                default: true
    t.integer  "patron_id",                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "action_level", limit: 2,  default: 0,    null: false
    t.string   "engine_name"
    t.index ["patron_id"], name: "index_nimbos_authorizations_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_nimbos_authorizations_on_user_id", using: :btree
  end

  create_table "nimbos_branches", force: :cascade do |t|
    t.string   "name",                limit: 40,                     null: false
    t.string   "tel",                 limit: 20
    t.string   "fax",                 limit: 20
    t.string   "email",               limit: 40
    t.string   "postcode",            limit: 10
    t.string   "address",             limit: 255
    t.string   "district",            limit: 40
    t.string   "city_name",           limit: 100
    t.string   "state",               limit: 100
    t.string   "country_id",          limit: 2
    t.string   "status",              limit: 10,  default: "active"
    t.integer  "patron_id",                                          null: false
    t.float    "lat"
    t.float    "lng"
    t.boolean  "gmaps"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "region_id"
    t.integer  "city_id"
    t.string   "profit_center_code",  limit: 100
    t.string   "ledger_account_code", limit: 100
    t.decimal  "score",                           default: "0.0",    null: false
    t.string   "code",                limit: 20
    t.integer  "manager_id"
    t.index ["manager_id"], name: "index_nimbos_branches_on_manager_id", using: :btree
    t.index ["patron_id"], name: "index_nimbos_branches_on_patron_id", using: :btree
  end

  create_table "nimbos_cities", force: :cascade do |t|
    t.string   "code"
    t.string   "name",                 null: false
    t.string   "tel_code"
    t.string   "country_id", limit: 2, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["country_id"], name: "index_nimbos_cities_on_country_id", using: :btree
  end

  create_table "nimbos_comments", force: :cascade do |t|
    t.integer  "user_id",                                   null: false
    t.text     "comment_text",                              null: false
    t.string   "commentable_type", limit: 40
    t.integer  "commentable_id"
    t.string   "commenter",        limit: 1,  default: "U"
    t.integer  "patron_id",                                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.string   "color"
    t.string   "visitor_name",     limit: 50
    t.index ["commentable_type", "commentable_id"], name: "index_nimbos_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["patron_id"], name: "index_nimbos_comments_on_patron_id", using: :btree
  end

  create_table "nimbos_comminfos", force: :cascade do |t|
    t.string   "comm_type",       limit: 100,                    null: false
    t.string   "comm_ref",                                       null: false
    t.string   "comm_text"
    t.string   "profile_address"
    t.string   "status",          limit: 20,  default: "active"
    t.string   "parent_type",                                    null: false
    t.integer  "parent_id",                                      null: false
    t.integer  "user_id",                                        null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["parent_type", "parent_id"], name: "index_nimbos_comminfos_on_parent_type_and_parent_id", using: :btree
    t.index ["user_id"], name: "index_nimbos_comminfos_on_user_id", using: :btree
  end

  create_table "nimbos_counters", force: :cascade do |t|
    t.string   "counter_type",     limit: 255
    t.integer  "count"
    t.string   "prefix",           limit: 255
    t.string   "suffix",           limit: 255
    t.integer  "period"
    t.boolean  "confirmed"
    t.integer  "patron_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",           limit: 30,  default: "active"
    t.string   "period_scope",     limit: 10,  default: "year"
    t.string   "engine",           limit: 30
    t.integer  "active_year"
    t.integer  "active_month"
    t.integer  "count_str_length"
    t.string   "name",             limit: 50
    t.index ["patron_id"], name: "index_nimbos_counters_on_patron_id", using: :btree
  end

  create_table "nimbos_countries", primary_key: "code", id: :string, limit: 2, force: :cascade do |t|
    t.string   "name",          limit: 40,                  null: false
    t.string   "telcode",       limit: 10
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "locale",        limit: 20
    t.string   "language",      limit: 10
    t.string   "time_zone",     limit: 255
    t.string   "mail_encoding", limit: 20
    t.string   "domain",        limit: 10
    t.string   "code3",         limit: 3
    t.string   "currency",      limit: 20
    t.string   "region",        limit: 100
    t.string   "subregion",     limit: 100
    t.boolean  "listable",                  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uic_code",      limit: 20
    t.boolean  "eu_union",                  default: false
    t.string   "name_tr",       limit: 100
    t.string   "name_de",       limit: 100
    t.string   "name_ro",       limit: 100
    t.string   "name_fr",       limit: 100
    t.string   "name_es",       limit: 100
    t.string   "name_az",       limit: 100
    t.string   "name_bg",       limit: 100
  end

  create_table "nimbos_currencies", force: :cascade do |t|
    t.string   "code",       limit: 5,                            null: false
    t.string   "name",       limit: 40,                           null: false
    t.string   "symbol",     limit: 1
    t.decimal  "multiplier",            precision: 5, default: 1, null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "nimbos_discussions", force: :cascade do |t|
    t.string   "title",          limit: 255,             null: false
    t.text     "content"
    t.string   "target_type",    limit: 50
    t.integer  "target_id"
    t.integer  "user_id",                                null: false
    t.integer  "patron_id",                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",             default: 0
    t.index ["patron_id"], name: "index_nimbos_discussions_on_patron_id", using: :btree
    t.index ["target_type", "target_id"], name: "index_nimbos_discussions_on_target_type_and_target_id", using: :btree
  end

  create_table "nimbos_group_contacts", force: :cascade do |t|
    t.integer "group_id"
    t.integer "contact_id"
  end

  create_table "nimbos_group_users", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.index ["group_id", "user_id"], name: "index_nimbos_group_users_on_group_id_and_user_id", using: :btree
  end

  create_table "nimbos_groups", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.string   "grouped_type",       limit: 100
    t.integer  "grouped_id"
    t.boolean  "hidden",                         default: false
    t.integer  "admin_id",                                       null: false
    t.integer  "patron_id",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                 default: 0
    t.integer  "tasks_count",                    default: 0
    t.integer  "reminders_count",                default: 0
    t.integer  "todolists_count",    limit: 2,   default: 0
    t.integer  "posts_count",        limit: 2,   default: 0
    t.integer  "s3files_count",      limit: 2,   default: 0
    t.integer  "docfiles_count",     limit: 2,   default: 0
    t.integer  "emails_count",       limit: 2,   default: 0
    t.integer  "sms_messages_count", limit: 2,   default: 0
    t.integer  "todos_count",                    default: 0
    t.index ["grouped_type", "grouped_id"], name: "index_nimbos_groups_on_grouped_type_and_grouped_id", using: :btree
    t.index ["patron_id"], name: "index_nimbos_groups_on_patron_id", using: :btree
    t.index ["title"], name: "index_nimbos_groups_on_title", using: :btree
  end

  create_table "nimbos_listheaders", force: :cascade do |t|
    t.string   "code",        limit: 255, null: false
    t.string   "name",        limit: 255
    t.string   "i18n_code",   limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nimbos_listitems", force: :cascade do |t|
    t.string   "code",          limit: 50,  null: false
    t.string   "name",          limit: 50
    t.string   "list_code",     limit: 255
    t.string   "i18n_code",     limit: 255
    t.integer  "listheader_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["listheader_id"], name: "index_nimbos_listitems_on_listheader_id", using: :btree
  end

  create_table "nimbos_menu_users", id: false, force: :cascade do |t|
    t.integer "menu_id"
    t.integer "user_id"
    t.index ["user_id", "menu_id"], name: "index_nimbos_menu_users_on_user_id_and_menu_id", using: :btree
  end

  create_table "nimbos_menus", force: :cascade do |t|
    t.string   "label",      limit: 50
    t.string   "i18n_code",  limit: 255
    t.string   "icon",       limit: 30
    t.string   "url",        limit: 2000
    t.string   "app_model",  limit: 50
    t.integer  "patron_id",               null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["patron_id"], name: "index_nimbos_menus_on_patron_id", using: :btree
  end

  create_table "nimbos_partners", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "partner_id"
    t.boolean  "shared_ledger"
    t.boolean  "shared_fleet"
    t.boolean  "shared_operation"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["partner_id"], name: "index_nimbos_partners_on_partner_id", using: :btree
    t.index ["patron_id"], name: "index_nimbos_partners_on_patron_id", using: :btree
  end

  create_table "nimbos_patrons", force: :cascade do |t|
    t.string   "name",                   limit: 40,                      null: false
    t.string   "title",                  limit: 120
    t.string   "email",                  limit: 60,                      null: false
    t.string   "website",                limit: 60
    t.string   "tel",                    limit: 20
    t.string   "fax",                    limit: 20
    t.string   "gsm",                    limit: 20
    t.string   "postcode",               limit: 10
    t.string   "address",                limit: 255
    t.string   "contact_name",           limit: 40
    t.string   "contact_surname",        limit: 40
    t.string   "city_name",              limit: 100
    t.string   "state",                  limit: 100
    t.string   "country_id",             limit: 2
    t.string   "patron_type",            limit: 20
    t.string   "employees",              limit: 10
    t.string   "language",               limit: 2
    t.string   "status",                 limit: 10,  default: "active"
    t.string   "logo",                   limit: 255
    t.string   "patron_token",           limit: 40
    t.string   "time_zone",              limit: 30
    t.string   "district",               limit: 40
    t.string   "currency",               limit: 10
    t.string   "locale",                 limit: 20
    t.string   "mail_encoding",          limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "appname",                limit: 30
    t.decimal  "credit_limit",                       default: "0.0"
    t.string   "tax_no",                 limit: 30
    t.string   "tax_office",             limit: 100
    t.integer  "remained_coins",                     default: 0
    t.string   "police",                 limit: 40
    t.boolean  "demo",                               default: false
    t.integer  "region_id"
    t.integer  "city_id"
    t.integer  "broker_id"
    t.string   "bank",                   limit: 50,  default: "tcmb"
    t.string   "curr_type",              limit: 30,  default: "selling"
    t.integer  "payment_day"
    t.integer  "company_id"
    t.string   "iban_details",           limit: 255
    t.string   "registration_system_no"
    t.string   "commercial_register_no"
    t.string   "work_type",              limit: 50
    t.boolean  "send_reminder",                      default: false
    t.string   "eori_code"
    t.integer  "invoice_company_id"
    t.integer  "tariff_id"
    t.string   "payment_type",           limit: 10,  default: "invoice"
    t.string   "payment_curr",           limit: 3
    t.string   "payment_period",         limit: 10,  default: "monthly"
    t.decimal  "second_limit",                       default: "0.0"
    t.date     "second_limit_due_date"
    t.jsonb    "engine_names"
    t.integer  "step_no",                            default: 1
    t.string   "persona"
    t.index ["company_id"], name: "index_nimbos_patrons_on_company_id", using: :btree
    t.index ["invoice_company_id"], name: "index_nimbos_patrons_on_invoice_company_id", using: :btree
    t.index ["tariff_id"], name: "index_nimbos_patrons_on_tariff_id", using: :btree
  end

  create_table "nimbos_posts", force: :cascade do |t|
    t.integer  "user_id",                                    null: false
    t.text     "message",                                    null: false
    t.string   "target_type",    limit: 40
    t.integer  "target_id"
    t.string   "target_title",   limit: 255
    t.string   "target_url",     limit: 255
    t.boolean  "is_private",                 default: false
    t.boolean  "is_syspost",                 default: false
    t.integer  "patron_id",                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "parent_type",    limit: 40
    t.integer  "parent_id"
    t.string   "parent_title",   limit: 255
    t.string   "parent_url",     limit: 255
    t.string   "post_action",    limit: 50
    t.string   "channel",        limit: 50
    t.boolean  "trashed",                    default: false
    t.integer  "comments_count",             default: 0
    t.integer  "likes_count",                default: 0
    t.integer  "group_id"
    t.index ["patron_id"], name: "index_nimbos_posts_on_patron_id", using: :btree
    t.index ["target_type", "target_id"], name: "index_nimbos_posts_on_target_type_and_target_id", using: :btree
    t.index ["user_id"], name: "index_nimbos_posts_on_user_id", using: :btree
  end

  create_table "nimbos_private_users", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "parent_type", null: false
    t.integer  "parent_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["parent_type", "parent_id"], name: "index_nimbos_private_users_on_parent_type_and_parent_id", using: :btree
    t.index ["user_id"], name: "index_nimbos_private_users_on_user_id", using: :btree
  end

  create_table "nimbos_regions", force: :cascade do |t|
    t.string   "name",       limit: 100, null: false
    t.integer  "city_id"
    t.string   "country_id", limit: 2
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "dask_id"
    t.index ["city_id"], name: "index_nimbos_regions_on_city_id", using: :btree
    t.index ["country_id"], name: "index_nimbos_regions_on_country_id", using: :btree
  end

  create_table "nimbos_reminders", force: :cascade do |t|
    t.string   "title",          limit: 255,                 null: false
    t.date     "start_date",                                 null: false
    t.string   "start_hour",     limit: 5
    t.date     "finish_date"
    t.string   "calendar_scope", limit: 40
    t.text     "description"
    t.string   "remindfor_type", limit: 100
    t.integer  "remindfor_id"
    t.integer  "user_id",                                    null: false
    t.integer  "patron_id",                                  null: false
    t.boolean  "trashed",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.index ["patron_id"], name: "index_nimbos_reminders_on_patron_id", using: :btree
    t.index ["remindfor_type", "remindfor_id"], name: "index_nimbos_reminders_on_remindfor_type_and_remindfor_id", using: :btree
  end

  create_table "nimbos_roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id"
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",         limit: 100
    t.index ["name", "resource_type", "resource_id"], name: "index_nimbos_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_nimbos_roles_on_name", using: :btree
  end

  create_table "nimbos_service_accounts", force: :cascade do |t|
    t.integer  "patron_id",                                          null: false
    t.string   "service_type",         limit: 50
    t.string   "service_code",         limit: 50
    t.string   "service_uname"
    t.string   "service_pwd",          limit: 50
    t.string   "status",                          default: "active"
    t.jsonb    "options"
    t.text     "einvoice_template"
    t.text     "earchive_template"
    t.text     "en_earchive_template"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.index ["patron_id"], name: "index_nimbos_service_accounts_on_patron_id", using: :btree
  end

  create_table "nimbos_states", force: :cascade do |t|
    t.string   "code",       limit: 30
    t.string   "name",       limit: 60, null: false
    t.string   "country_id", limit: 2,  null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["country_id"], name: "index_nimbos_states_on_country_id", using: :btree
  end

  create_table "nimbos_taggings", force: :cascade do |t|
    t.integer  "tag_id",      null: false
    t.integer  "parent_id",   null: false
    t.string   "parent_type", null: false
    t.integer  "patron_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["parent_type", "parent_id"], name: "index_nimbos_taggings_on_parent_type_and_parent_id", using: :btree
    t.index ["patron_id"], name: "index_nimbos_taggings_on_patron_id", using: :btree
    t.index ["tag_id", "parent_type", "parent_id", "patron_id"], name: "nimbos_taggings_unique_tag", unique: true, using: :btree
    t.index ["tag_id"], name: "index_nimbos_taggings_on_tag_id", using: :btree
  end

  create_table "nimbos_tags", force: :cascade do |t|
    t.string   "name",       limit: 50, null: false
    t.string   "tag_type",   limit: 50
    t.integer  "patron_id",             null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["name", "tag_type", "patron_id"], name: "index_nimbos_tags_on_name_and_patron_id", unique: true, using: :btree
    t.index ["name"], name: "index_nimbos_tags_on_name", using: :btree
    t.index ["patron_id"], name: "index_nimbos_tags_on_patron_id", using: :btree
  end

  create_table "nimbos_tasks", force: :cascade do |t|
    t.integer  "todolist_id",                                   null: false
    t.integer  "user_id"
    t.string   "task_text",      limit: 255,                    null: false
    t.string   "task_code",      limit: 50
    t.string   "i18n_code",      limit: 50
    t.integer  "cruser_id"
    t.string   "status",         limit: 10,  default: "active"
    t.date     "due_date"
    t.date     "closed_date"
    t.string   "close_text",     limit: 255
    t.boolean  "system_task",                default: false
    t.integer  "patron_id",                                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",             default: 0
    t.string   "color"
    t.integer  "group_id"
    t.index ["patron_id"], name: "index_nimbos_tasks_on_patron_id", using: :btree
    t.index ["todolist_id"], name: "index_nimbos_tasks_on_todolist_id", using: :btree
    t.index ["user_id"], name: "index_nimbos_tasks_on_user_id", using: :btree
  end

  create_table "nimbos_todolists", force: :cascade do |t|
    t.string   "name",        limit: 255,                 null: false
    t.integer  "user_id",                                 null: false
    t.string   "todop_type",  limit: 100
    t.integer  "todop_id"
    t.integer  "patron_id",                               null: false
    t.integer  "tasks_count",             default: 0
    t.boolean  "trashed",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.boolean  "isdefault",               default: false
    t.index ["patron_id"], name: "index_nimbos_todolists_on_patron_id", using: :btree
    t.index ["todop_type", "todop_id"], name: "index_nimbos_todolists_on_todop_type_and_todop_id", using: :btree
    t.index ["user_id"], name: "index_nimbos_todolists_on_user_id", using: :btree
  end

  create_table "nimbos_user_logins", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "ip_addr"
    t.string   "device_name"
    t.string   "os_version"
    t.string   "browser_type"
    t.string   "location"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["browser_type"], name: "index_nimbos_user_logins_on_browser_type", using: :btree
    t.index ["user_id"], name: "index_nimbos_user_logins_on_user_id", using: :btree
  end

  create_table "nimbos_users", force: :cascade do |t|
    t.string   "email",                           limit: 40,                                          null: false
    t.string   "password_digest",                 limit: 255
    t.string   "salt",                            limit: 255
    t.string   "name",                            limit: 40
    t.string   "gsm",                             limit: 40
    t.integer  "patron_id"
    t.string   "auth_type",                       limit: 20,   default: "all"
    t.string   "language",                        limit: 255,  default: "en"
    t.string   "time_zone",                       limit: 255,  default: "Eastern Time (US & Canada)"
    t.string   "locale",                          limit: 8
    t.string   "user_type",                       limit: 10,   default: "staff"
    t.string   "mail_encoding",                   limit: 20
    t.datetime "last_login_at"
    t.string   "activation_state",                limit: 255
    t.string   "activation_token",                limit: 255
    t.datetime "activation_token_expires_at"
    t.string   "password_reset_token",            limit: 255
    t.datetime "password_reset_token_expires_at"
    t.integer  "company_id"
    t.string   "avatar",                          limit: 255
    t.integer  "branch_id",                                    default: 0,                            null: false
    t.boolean  "firstuser",                                    default: false
    t.string   "user_status",                     limit: 10,   default: "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "rootuser",                                     default: false,                        null: false
    t.boolean  "authorized",                                   default: false,                        null: false
    t.integer  "manager_id"
    t.string   "jobtitle"
    t.boolean  "smtp_enabled",                                 default: false
    t.string   "smtp_address",                    limit: 100
    t.integer  "smtp_port",                                    default: 587
    t.string   "smtp_domain",                     limit: 100
    t.string   "smtp_user_name",                  limit: 100
    t.string   "smtp_user_password",              limit: 100
    t.string   "smtp_user_signature",             limit: 1000
    t.string   "office_tel",                      limit: 30
    t.string   "ext_tel",                         limit: 10
    t.string   "status_note",                     limit: 255
    t.string   "uname",                           limit: 100
    t.integer  "operation_id"
    t.integer  "person_id"
    t.string   "identity_no",                     limit: 100
    t.integer  "parent_patron_id"
    t.integer  "failed_attempts",                              default: 0
    t.string   "device_token",                    limit: 1000
    t.index ["email"], name: "index_nimbos_users_on_email", unique: true, using: :btree
    t.index ["parent_patron_id"], name: "index_nimbos_users_on_parent_patron_id", using: :btree
    t.index ["patron_id"], name: "index_nimbos_users_on_patron_id", using: :btree
    t.index ["person_id"], name: "index_nimbos_users_on_person_id", using: :btree
  end

  create_table "nimbos_users_patrons", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "patron_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nimbos_users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_nimbos_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "roster_agings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roster_charts", force: :cascade do |t|
    t.string   "name",         limit: 100
    t.text     "query"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "model",        limit: 50
    t.string   "class_method", limit: 100
  end

  create_table "roster_data_fields", force: :cascade do |t|
    t.integer  "data_table_id",                                null: false
    t.string   "name",             limit: 255,                 null: false
    t.string   "data_type",        limit: 100,                 null: false
    t.boolean  "importable",                   default: true
    t.boolean  "summable",                     default: false
    t.boolean  "orderable",                    default: true
    t.boolean  "groupable",                    default: false
    t.boolean  "filterable",                   default: true
    t.string   "filter_data_type", limit: 100,                 null: false
    t.string   "local_code",       limit: 100
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["data_table_id"], name: "index_roster_data_fields_on_data_table_id", using: :btree
  end

  create_table "roster_data_tables", force: :cascade do |t|
    t.string   "name",        limit: 50,                 null: false
    t.string   "engine",      limit: 50,                 null: false
    t.boolean  "has_counter",            default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "table_name",  limit: 50
    t.boolean  "need_auth",              default: true
    t.index ["name"], name: "index_roster_data_tables_on_name", using: :btree
  end

  create_table "roster_report_templatelines", force: :cascade do |t|
    t.integer  "report_template_id",                             null: false
    t.string   "col_type",           limit: 100
    t.string   "col_name",           limit: 100
    t.string   "col_title",          limit: 100
    t.text     "reference_type"
    t.string   "reference_col",      limit: 100
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "col_number"
    t.boolean  "groupable",                      default: false
  end

  create_table "roster_report_templates", force: :cascade do |t|
    t.integer  "patron_id"
    t.integer  "user_id"
    t.string   "parent",                 null: false
    t.string   "title"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "join_str",   limit: 500
    t.string   "where_str",  limit: 500
    t.string   "order_str",  limit: 500
    t.index ["patron_id"], name: "index_roster_report_templates_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_roster_report_templates_on_user_id", using: :btree
  end

  create_table "roster_reportlines", force: :cascade do |t|
    t.integer  "report_id"
    t.integer  "parent_id"
    t.string   "parent_type", limit: 100
    t.string   "line_type",   limit: 100
    t.string   "status",      limit: 10,  default: "pending"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "col0",        limit: 255
    t.string   "col1",        limit: 255
    t.string   "col2",        limit: 255
    t.string   "col3",        limit: 255
    t.string   "col4",        limit: 255
    t.string   "col5",        limit: 255
    t.string   "col6",        limit: 255
    t.string   "col7",        limit: 255
    t.string   "col8",        limit: 255
    t.string   "col9",        limit: 255
    t.string   "col10",       limit: 255
    t.string   "col11",       limit: 255
    t.string   "col12",       limit: 255
    t.string   "col13",       limit: 255
    t.string   "col14",       limit: 255
    t.string   "col15",       limit: 255
    t.string   "col16",       limit: 255
    t.string   "col17",       limit: 255
    t.string   "col18",       limit: 255
    t.string   "col19",       limit: 255
    t.string   "col20",       limit: 255
    t.string   "col21",       limit: 255
    t.string   "col22",       limit: 255
    t.string   "col23",       limit: 255
    t.string   "col24",       limit: 255
    t.string   "col25",       limit: 255
    t.string   "col26",       limit: 255
    t.string   "col27",       limit: 255
    t.string   "col28",       limit: 255
    t.string   "col29",       limit: 255
    t.string   "col30",       limit: 255
    t.string   "col31",       limit: 255
    t.string   "col32",       limit: 255
    t.string   "col33",       limit: 255
    t.string   "col34",       limit: 255
    t.string   "col35",       limit: 255
    t.string   "col36",       limit: 255
    t.string   "col37",       limit: 255
    t.string   "col38",       limit: 255
    t.string   "col39",       limit: 255
    t.string   "col40",       limit: 255
    t.string   "col41",       limit: 255
    t.string   "col42",       limit: 255
    t.string   "col43",       limit: 255
    t.string   "col44",       limit: 255
    t.string   "col45",       limit: 255
    t.string   "col46",       limit: 255
    t.string   "col47",       limit: 255
    t.string   "col48",       limit: 255
    t.string   "col49",       limit: 255
    t.string   "col50",       limit: 255
    t.index ["report_id"], name: "index_roster_reportlines_on_report_id", using: :btree
  end

  create_table "roster_reports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "patron_id"
    t.string   "title",              limit: 100
    t.string   "status",             limit: 10,  default: "pending"
    t.integer  "report_template_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.index ["patron_id"], name: "index_roster_reports_on_patron_id", using: :btree
    t.index ["user_id"], name: "index_roster_reports_on_user_id", using: :btree
  end

  create_table "roster_searches", force: :cascade do |t|
    t.string   "model",             limit: 30,                       null: false
    t.string   "reference",         limit: 40
    t.integer  "user_id",                                            null: false
    t.integer  "patron_id",                                          null: false
    t.string   "search_type",       limit: 10,  default: "detailed"
    t.hstore   "filter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "list_partial_file", limit: 255
    t.string   "search_form",       limit: 255
    t.string   "title",             limit: 100
    t.boolean  "is_default",                    default: false
    t.string   "class_method",      limit: 100
    t.integer  "perpage",           limit: 2,   default: 10
    t.string   "sort_fields",       limit: 255
    t.boolean  "will_paginate",                 default: true
    t.boolean  "private",                       default: false
    t.string   "orientation",       limit: 30
    t.boolean  "page_title",                    default: true
  end

  create_table "roster_searches_list_fields", force: :cascade do |t|
    t.integer "search_id",     null: false
    t.integer "data_field_id", null: false
    t.index ["data_field_id"], name: "index_roster_searches_list_fields_on_data_field_id", using: :btree
    t.index ["search_id"], name: "index_roster_searches_list_fields_on_search_id", using: :btree
  end

  create_table "roster_searches_order_fields", force: :cascade do |t|
    t.integer "search_id",                                null: false
    t.integer "data_field_id",                            null: false
    t.string  "direction",     limit: 10, default: "asc"
    t.index ["data_field_id"], name: "index_roster_searches_order_fields_on_data_field_id", using: :btree
    t.index ["search_id"], name: "index_roster_searches_order_fields_on_search_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

  create_table "surveyor_betausers", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "name",       limit: 100
    t.string   "company",    limit: 100
    t.string   "phone",      limit: 30
    t.string   "country",    limit: 20
    t.string   "ipaddr",     limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveyor_feedbacks", force: :cascade do |t|
    t.string   "name",       limit: 40,  null: false
    t.string   "email",      limit: 100
    t.string   "msg",        limit: 500
    t.integer  "user_id"
    t.integer  "patron_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "name",          limit: 255,                    null: false
    t.string   "code",          limit: 20,                     null: false
    t.string   "vehicle_class", limit: 20
    t.string   "brand",         limit: 20
    t.string   "model",         limit: 50
    t.integer  "model_year"
    t.integer  "fuel_capacity"
    t.string   "fuel_type",     limit: 10
    t.string   "status",        limit: 20,  default: "active"
    t.date     "purchase_date"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "driver_id"
  end

  add_foreign_key "arsiv_approvals_users", "arsiv_approvals", column: "approval_id"
  add_foreign_key "arsiv_docfiles", "arsiv_documents", column: "document_id"
  add_foreign_key "arsiv_docfiles", "messenger_emails", column: "email_id"
  add_foreign_key "arsiv_doctemplates", "nimbos_patrons", column: "patron_id"
  add_foreign_key "arsiv_doctemplates", "nimbos_users", column: "user_id"
  add_foreign_key "customs_guarantors", "network_companies", column: "company_id"
  add_foreign_key "customs_guarantors", "network_contacts", column: "contact_id"
  add_foreign_key "customs_guarantors", "nimbos_patrons", column: "patron_id"
  add_foreign_key "customs_guarantors", "nimbos_users", column: "user_id"
  add_foreign_key "customs_transit_countries", "customs_manifestos", column: "manifesto_id"
  add_foreign_key "customs_transit_customs", "customs_manifestos", column: "manifesto_id"
  add_foreign_key "customs_transit_customs", "logistics_places", column: "place_id"
  add_foreign_key "depot_barcodefields", "depot_barcodes", column: "barcode_id"
  add_foreign_key "depot_barcodes", "depot_wareprojects", column: "wareproject_id"
  add_foreign_key "depot_motion_pallets", "depot_motions", column: "motion_id"
  add_foreign_key "depot_motion_pallets", "depot_pallets", column: "pallet_id"
  add_foreign_key "depot_motions", "depot_motions", column: "parent_motion_id"
  add_foreign_key "depot_motions", "depot_products", column: "product_id"
  add_foreign_key "depot_motions", "depot_tariffs", column: "tariff_id"
  add_foreign_key "depot_motions", "depot_warehouses", column: "warehouse_id"
  add_foreign_key "depot_motions", "depot_wareprojects", column: "wareproject_id"
  add_foreign_key "depot_motions", "network_companies", column: "company_id"
  add_foreign_key "depot_orders", "depot_warehouses", column: "warehouse_id"
  add_foreign_key "depot_orders", "depot_wareprojects", column: "wareproject_id"
  add_foreign_key "depot_orders", "network_companies", column: "company_id"
  add_foreign_key "depot_product_groups", "depot_wareprojects", column: "wareproject_id"
  add_foreign_key "depot_product_parts", "depot_products", column: "parent_product_id"
  add_foreign_key "depot_product_parts", "depot_products", column: "sub_product_id"
  add_foreign_key "depot_products", "depot_product_groups", column: "product_group_id"
  add_foreign_key "depot_products", "depot_wareprojects", column: "wareproject_id"
  add_foreign_key "depot_products", "network_companies", column: "company_id"
  add_foreign_key "depot_shelves", "depot_warehouses", column: "warehouse_id"
  add_foreign_key "depot_tarifflines", "depot_tariffs", column: "tariff_id"
  add_foreign_key "depot_tariffs", "depot_warehouses", column: "warehouse_id"
  add_foreign_key "depot_tariffs", "network_companies", column: "company_id"
  add_foreign_key "depot_wareprojects", "depot_warehouses", column: "warehouse_id"
  add_foreign_key "depot_wareprojects", "network_companies", column: "company_id"
  add_foreign_key "depot_wareprojects_companies", "depot_wareprojects", column: "wareproject_id"
  add_foreign_key "depot_wareprojects_companies", "network_companies", column: "company_id"
  add_foreign_key "financor_accounts", "financor_ledger_accounts", column: "ledger_account_id"
  add_foreign_key "financor_accounts", "nimbos_patrons", column: "patron_id"
  add_foreign_key "financor_accounts", "nimbos_users", column: "user_id"
  add_foreign_key "financor_agreements", "nimbos_patrons", column: "patron_id"
  add_foreign_key "financor_agreements", "nimbos_users", column: "user_id"
  add_foreign_key "financor_chartofaccounts", "nimbos_patrons", column: "patron_id"
  add_foreign_key "financor_chartofaccounts", "nimbos_users", column: "user_id"
  add_foreign_key "financor_findoc_types", "nimbos_patrons", column: "patron_id"
  add_foreign_key "financor_findoclines", "financor_accounts", column: "account_id"
  add_foreign_key "financor_findoclines", "nimbos_patrons", column: "patron_id"
  add_foreign_key "financor_findocs", "financor_accounts", column: "account_id"
  add_foreign_key "financor_findocs", "financor_accounts", column: "related_account_id"
  add_foreign_key "financor_findocs", "financor_ledger_accounts", column: "cost_account_id"
  add_foreign_key "financor_findocs", "nimbos_patrons", column: "patron_id"
  add_foreign_key "financor_findocs", "nimbos_users", column: "user_id"
  add_foreign_key "financor_finitems", "nimbos_patrons", column: "patron_id"
  add_foreign_key "financor_finitems", "nimbos_users", column: "user_id"
  add_foreign_key "financor_finpoints", "nimbos_users", column: "user_id"
  add_foreign_key "financor_involines", "financor_finitems", column: "finitem_id"
  add_foreign_key "financor_ledger_sums", "financor_ledger_accounts", column: "ledger_account_id"
  add_foreign_key "financor_ledgerlines", "financor_ledger_accounts", column: "ledger_account_id"
  add_foreign_key "financor_ledgerlines", "nimbos_patrons", column: "patron_id"
  add_foreign_key "financor_ledgers", "nimbos_patrons", column: "patron_id"
  add_foreign_key "financor_ledgers", "nimbos_users", column: "user_id"
  add_foreign_key "fleet_gate_actions", "fleet_gate_actions", column: "output_action_id"
  add_foreign_key "hr_benefits", "hr_people", column: "person_id"
  add_foreign_key "hr_departments", "hr_offices", column: "office_id"
  add_foreign_key "hr_families", "hr_people", column: "person_id"
  add_foreign_key "hr_gvparams", "hr_sgkparams", column: "sgkparam_id"
  add_foreign_key "hr_identities", "hr_people", column: "person_id"
  add_foreign_key "hr_jobinfos", "hr_people", column: "person_id"
  add_foreign_key "hr_jobinfos", "nimbos_branches", column: "branch_id"
  add_foreign_key "hr_jobinfos", "nimbos_users", column: "manager_id"
  add_foreign_key "hr_offices", "nimbos_patrons", column: "patron_id"
  add_foreign_key "hr_offices", "nimbos_users", column: "user_id"
  add_foreign_key "hr_payroll_periods", "nimbos_patrons", column: "patron_id"
  add_foreign_key "hr_payroll_periods", "nimbos_users", column: "user_id"
  add_foreign_key "hr_person_sgkparams", "hr_people", column: "person_id"
  add_foreign_key "hr_timeoffs", "hr_people", column: "person_id"
  add_foreign_key "hr_timeoffs", "nimbos_patrons", column: "patron_id"
  add_foreign_key "hr_timeoffs", "nimbos_users", column: "user_id"
  add_foreign_key "hr_timeparams", "hr_sgkparams", column: "sgkparam_id"
  add_foreign_key "logistics_bookings", "logistics_loadings", column: "loading_id"
  add_foreign_key "logistics_bookings", "logistics_operations", column: "operation_id"
  add_foreign_key "logistics_bookings", "nimbos_patrons", column: "patron_id"
  add_foreign_key "logistics_bookings", "nimbos_users", column: "saler_id"
  add_foreign_key "logistics_bookings", "nimbos_users", column: "user_id"
  add_foreign_key "logistics_incoterms", "nimbos_patrons", column: "patron_id"
  add_foreign_key "logistics_incoterms", "nimbos_users", column: "user_id"
  add_foreign_key "logistics_operations", "nimbos_patrons", column: "patron_id"
  add_foreign_key "logistics_operations", "nimbos_users", column: "user_id"
  add_foreign_key "logistics_places", "nimbos_countries", column: "country_id", primary_key: "code"
  add_foreign_key "logistics_places", "nimbos_patrons", column: "patron_id"
  add_foreign_key "logistics_positions", "fleet_drivers", column: "driver_id"
  add_foreign_key "logistics_positions", "network_companies", column: "agent_id"
  add_foreign_key "logistics_positions", "network_companies", column: "owner_id"
  add_foreign_key "logistics_positions", "network_companies", column: "supplier_id"
  add_foreign_key "logistics_positions", "nimbos_branches", column: "branch_id"
  add_foreign_key "logistics_positions", "nimbos_patrons", column: "patron_id"
  add_foreign_key "logistics_positions", "nimbos_users", column: "user_id"
  add_foreign_key "logistics_tariff_full_prices", "logistics_tarifflines", column: "tariffline_id"
  add_foreign_key "logistics_tariff_partial_prices", "logistics_tarifflines", column: "tariffline_id"
  add_foreign_key "logistics_tarifflines", "logistics_tariffs", column: "tariff_id"
  add_foreign_key "logistics_transports", "logistics_loadings", column: "loading_id"
  add_foreign_key "logistics_transports", "network_companies", column: "owner_id"
  add_foreign_key "logistics_transports", "network_companies", column: "supplier_id"
  add_foreign_key "logistics_transports", "nimbos_branches", column: "branch_id"
  add_foreign_key "logistics_transports", "nimbos_patrons", column: "patron_id"
  add_foreign_key "logistics_transports", "nimbos_users", column: "user_id"
  add_foreign_key "logistics_voyageports", "logistics_voyages", column: "voyage_id"
  add_foreign_key "logistics_wagons", "logistics_transports", column: "transport_id"
  add_foreign_key "logistics_wagons", "nimbos_patrons", column: "patron_id"
  add_foreign_key "logistics_wagons", "nimbos_users", column: "user_id"
  add_foreign_key "roster_reportlines", "roster_reports", column: "report_id"
  add_foreign_key "roster_reports", "nimbos_patrons", column: "patron_id"
  add_foreign_key "roster_reports", "nimbos_users", column: "user_id"
end
