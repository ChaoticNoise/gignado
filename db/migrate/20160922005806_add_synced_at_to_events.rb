class AddSyncedAtToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :synced_at, :datetime
    add_column :events, :gigo_key, :string
  end
end
