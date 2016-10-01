class AllowEventTitleToBeNull < ActiveRecord::Migration[5.0]
  def change
    change_column(:events, :title, :string, null: true)
  end
end
