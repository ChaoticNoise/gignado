class Gig < Event
  store :data, accessors: [ :payment, :plus_ones_allowed, :merch_needs ]
  enum status: {potential: 0, confirmed: 1, canceled: 2}
  enum payment_status: {negotiation: 0, agreed: 1, overdue: 2, paid: 3, waived: 4}

  belongs_to :booker, class_name: "Member"
  belongs_to :day_pic, class_name: "Member"
  belongs_to :gig_pic, class_name: "Member"
  belongs_to :bus_pic, class_name: "Member"

  validate :confirmation_before_start

  def self.last_sync
    where("synced_at IS NOT NULL").order("synced_at").pluck(:synced_at).first
  end

  def self.confirmed
    # TODO handle other event confirmed types
    where(status: Gig.statuses[:confirmed])
  end

  protected
  def confirmation_before_start
    if confirmation_deadline && start_time < confirmation_deadline
      errors.add(:confirmation_deadline, "must be before start time")
    end
  end
end
