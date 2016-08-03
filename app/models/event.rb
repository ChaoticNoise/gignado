require 'date_time_util'

class Event < ActiveRecord::Base
  include DateTimeUtil

  serialize :data, HashSerializer

  store_accessor :data, :uid, :points
  attr_accessor :base_url

  validates :start_time, :end_time, :title, presence: true
  validate :start_before_end

  before_save :confirm_uid

  scope :upcoming, -> { where("end_time > ?", Time.zone.today) }
  scope :today, -> { where("end_time > ? AND start_time < ?", Date.today, 1.day.from_now.beginning_of_day) }

  def self.confirmed
    #TODO handle other event confirmed types
    where(status: Gig.statuses[:confirmed])
  end

  def self.search_by(column, query)
    where("lower(#{column}) LIKE ?", "%#{query.downcase}%")
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

  protected
  def start_before_end
    if start_time.present? && end_time.present? && start_time > end_time
      errors.add(:end_time, "can't be before the start")
    end
  end

  def confirm_uid
    ical_event unless uid
  end
end
