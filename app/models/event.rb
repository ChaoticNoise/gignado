require 'date_time_util'

class Event < ApplicationRecord
  include DateTimeUtil

  has_one :promotion

  serialize :data, HashSerializer

  store :data, accessors: [ :uid, :points ]
  attr_accessor :base_url

  before_save :confirm_uid

  scope :upcoming, -> { where("end_time > ?", Time.zone.today) }
  scope :today, -> { where("end_time > ? AND start_time < ?", Time.zone.today, 1.day.from_now.beginning_of_day) }

  def self.by_title(query)
    where("lower(title) LIKE ?", "%#{query.downcase}%")
  end

  def self.ical(events)
    cal = Icalendar::Calendar.new
    events.each { |e| cal.add_event(e.ical_event) }
    cal
  end

  def ical_event
    event = Icalendar::Event.new
    event.dtstart = start_time
    event.dtend = end_time
    event.summary = title
    event.uid = uid if uid
    self.uid = event.uid
    event
  end

  def to_ical
    ical_event.to_ical
  end

  def url
    "#{base_url}/#{type.downcase.pluralize}/#{id}"
  end

  def timezone
    Timezone['America/Los_Angeles']
  end

  def confirmation_deadline
    self.read_attribute(:confirmation_deadline) || self.start_time
  end

  def local_call_time
    self.timezone.utc_to_local(self.call_time)
  end

  def local_start_time
    self.timezone.utc_to_local(self.start_time)
  end

  def local_end_time
    self.timezone.utc_to_local(self.end_time)
  end

  def local_confirmation_deadline
    self.timezone.utc_to_local(self.confirmation_deadline)
  end

  def location_url
    "https://maps.google.com?q=#{self.location}"
  end

  protected

  def confirm_uid
    ical_event unless uid
  end
end
