class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.string :title, null: false
      t.string :status
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.text :details
      t.jsonb :data, null: false, default: '{}'
      t.timestamps null: false
    end

    add_index :events, :data, using: :gin
  end
end
