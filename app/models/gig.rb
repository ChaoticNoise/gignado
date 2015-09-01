class Gig < Event
  store_accessor :data, :confirmation_deadline, :play_times, :payment
  enum status: {potential: 0, confirmed: 1, canceled: 2}
  
  validate :confirmation_before_start

  def confirmation_deadline
    to_date_time(super)
  end
    
  protected
  def confirmation_before_start
    if confirmation_deadline && start_time < confirmation_deadline
      errors.add(:confirmation_deadline, "must be before start time")
    end
  end
end
