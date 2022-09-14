  create_table "memberships", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", default: 0, null: false
    t.integer "dealership_id", default: 0, null: false
    t.boolean "can_switch_to", default: false, null: false
    t.boolean "accept_leads", default: false, null: false
    t.integer "rr_assigned_today", default: 0, null: false
    t.integer "rr_behind_today", default: 0, null: false
    t.datetime "notifications_last_read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["dealership_id"], name: "index_memberships_on_dealership_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "message_templates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "dealership_id"
    t.string "name", collation: "utf8_general_ci"
    t.string "subject", limit: 100, collation: "utf8_general_ci"
    t.text "body", limit: 16777215, collation: "utf8_general_ci"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "text_message_body", limit: 1600, collation: "utf8_general_ci"
    t.text "json_body", limit: 16777215
    t.boolean "published"
    t.index ["dealership_id"], name: "index_message_templates_on_dealership_id"
  end

  create_table "notes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci STATS_AUTO_RECALC=0", force: :cascade do |t|
    t.integer "dealership_id"
    t.integer "user_id"
    t.integer "upsheet_id"
    t.integer "reference_id"
    t.string "reference_type", limit: 25, collation: "utf8_general_ci"
    t.string "event", limit: 15, collation: "utf8_general_ci"
    t.text "body", limit: 16777215, collation: "utf8mb4_general_ci"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["dealership_id", "created_at"], name: "index_notes_on_dealership_id_and_created_at"
    t.index ["dealership_id", "event", "created_at"], name: "index_notes_on_dealership_id_and_event_and_created_at"
    t.index ["event", "created_at"], name: "index_notes_on_event_and_created_at"
    t.index ["reference_id"], name: "index_notes_on_reference_id"
    t.index ["upsheet_id", "created_at"], name: "index_notes_on_upsheet_id_and_created_at"
  end

  create_table "notification_toggles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "notification_type", collation: "utf8_general_ci"
    t.boolean "enabled", default: true, null: false
  end
