class Promotion < ApplicationRecord
  belongs_to :event
  after_save :expire_upcoming_cache
  after_destroy :expire_upcoming_cache

  scope :upcoming, -> { joins(:event).where("events.end_time > ?", Time.zone.now).order("events.start_time") }

  def self.new_from_event(event)
    self.new(
        event_id: event.id,
        title: event.title,
        time_display: format_time_display(event.start_time, event.end_time),
        location_display: event.location,
        location_url: event.location_url
    )
  end

  def self.format_time_display(start_time, end_time)
    if start_time.beginning_of_day != end_time.beginning_of_day
      if start_time.month != end_time.month
        start_time = start_time.strftime("%b %-d")
        end_time = end_time.strftime("%b %-d")
        "#{start_time} - #{end_time}"
      else
        start_time = start_time.strftime("%b %-d")
        end_time = end_time.strftime("%b")
        "#{start_time} - #{end_time}"
      end
    else
      start_time.strftime("%a, %b %-d %-l:%M %p")
    end
  end

  def self.upcoming_cached
    Rails.cache.fetch('Promotion.upcoming', expires_in: 1.hours) { self.upcoming }
  end

  def expire_upcoming_cache
    Rails.cache.delete('Promotion.upcoming')
  end
end
