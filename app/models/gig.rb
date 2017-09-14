class Gig < Event
  store :data, accessors: [ :payment ]
  enum status: {potential: 0, confirmed: 1, canceled: 2}

  belongs_to :booker, class_name: "Member"
  belongs_to :day_pic, class_name: "Member"
  belongs_to :gig_pic, class_name: "Member"
  belongs_to :bus_pic, class_name: "Member"

  alias_attribute :set_time, :start_time

  scope :confirmed, -> { where(status: Gig.statuses[:confirmed]) }

  def self.last_sync
    self.last_date_value(:synced_at)
  end
end
