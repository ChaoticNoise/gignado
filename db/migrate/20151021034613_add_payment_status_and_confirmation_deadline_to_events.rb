class AddPaymentStatusAndConfirmationDeadlineToEvents < ActiveRecord::Migration
  def change
    add_column :events, :confirmation_deadline, :datetime
    add_column :events, :payment_status, :integer, default: 0
  end
end
