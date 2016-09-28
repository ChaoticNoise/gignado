class EventsController < ApplicationController

  # GET /events
  # GET /events.json
  # GET /events.ics
  def index
    @events = Event.upcoming.order(:start_time)
    @events_cal = Event.ical(@events) if params[:format] == 'ics'
  end
end
