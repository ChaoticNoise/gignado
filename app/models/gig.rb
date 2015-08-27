class Gig < Event
  store_accessor :data, :confirmation_deadline, :play_times, :payment
  enum status: {potential: 0, confirmed: 1, canceled: 2}

  def confirmation_deadline
    DateTime.new(*super.values) if super
  end
end
