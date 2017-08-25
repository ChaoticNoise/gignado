class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.string "title"
      t.string "url"
      t.datetime "start_time"
      t.datetime "end_time"
      t.string "time_display"
      t.string "location_display"
      t.string "location_url"
      t.text "details"
      t.integer "event_id"
      t.timestamps null: false
    end
  end
end
