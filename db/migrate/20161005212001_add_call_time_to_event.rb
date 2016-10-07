class AddCallTimeToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :call_time, :datetime
  end
end
