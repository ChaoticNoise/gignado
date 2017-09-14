class RemovePromotionFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :promotions, :start_time
    remove_column :promotions, :end_time
    remove_column :promotions, :details
  end
end
