class EventsSyncJob < ApplicationJob
  queue_as :events_sync

  def perform(*args)
    @@lock ||= false

    unless @@lock
      @@lock = true
      gigs = GigOMatic::Service.new().gigs
      Gig::SyncFromGigo.new(gigs).update()
    end

  ensure
    @@lock = false
  end

end
