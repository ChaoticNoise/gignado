class Gig < Event
  store_accessor :data, :confirmation_deadline, :play_times, :payment

  def confirmation_deadline
    DateTime.new(*super.values) if super
  end
end
