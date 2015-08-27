class ConvertStatusToEnum < ActiveRecord::Migration
  def change
    remove_column :events, :status, :string
    add_column :events, :status, :integer, :default => 0
  end
end
