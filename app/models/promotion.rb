class Promotion < ApplicationRecord
  belongs_to :event
  after_save :expire_upcoming_cache
  after_destroy :expire_upcoming_cache

  scope :upcoming, -> { where("end_time > ?", Time.zone.today).order(:start_time) }

  def self.new_from_event(event)
    self.new(
        event_id: event.id,
        title: event.title,
        location_display: event.location,
        location_url: event.location_url,
        start_time: event.start_time,
        end_time: event.end_time
    )
  end

  def self.upcoming_cached
    Rails.cache.fetch('Promotion.upcoming', expires_in: 12.hours) { self.upcoming }
  end

  def expire_upcoming_cache
    Rails.cache.delete('Promotion.upcoming')
  end
end