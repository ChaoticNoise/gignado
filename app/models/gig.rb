class Gig < Event
  store_accessor :data, :confirmation_deadline, :play_times, :payment, :payment_status, :booker, :day_pic,
#    :is_public, :public_start, :public_end, :public_title, :public_description, :public_location,
    :plus_ones_allowed, :merch_needs
  enum status: {potential: 0, confirmed: 1, canceled: 2}
  enum payment_status: {negotiation: 0, agreed: 1, overdue: 2, paid: 3, waived: 4}
  
  validate :confirmation_before_start

  def confirmation_deadline
    to_date_time(super)
  end
  
  def confirmation_deadline=(val)
    super to_date_time(val)
  end
    
  protected
  def confirmation_before_start
    if confirmation_deadline && start_time < confirmation_deadline
      errors.add(:confirmation_deadline, "must be before start time")
    end
  end
end
