class AddActivatedAtToMembers < ActiveRecord::Migration
  def change
    add_column :members, :activated_at, :datetime
  end
end
