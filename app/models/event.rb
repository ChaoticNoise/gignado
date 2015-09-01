require 'date_time_util'

class Event < ActiveRecord::Base
  include DateTimeUtil
  
  serialize :data, HashSerializer
  
  store_accessor :data, :uid

  validates :start_time, :end_time, :title, presence: true
  validate :start_before_end
  
  before_save :confirm_uid
  
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
  
  protected
  def start_before_end
    if start_time > end_time
      errors.add(:end_time, "can't be before the start")
    end
  end
  
  def confirm_uid
    ical_event unless uid
  end
end
