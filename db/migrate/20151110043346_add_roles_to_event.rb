class AddRolesToEvent < ActiveRecord::Migration
  def change
    add_column :events, :booker_id, :integer, index: true
    add_column :events, :day_pic_id, :integer, index: true
    add_column :events, :gig_pic_id, :integer, index: true
    add_column :events, :bus_pic_id, :integer, index: true
    add_column :events, :rehearsal_pic_id, :integer, index: true
  end
end
