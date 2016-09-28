class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  helper_method :sync_date

  # GET /events
  # GET /events.json
  # GET /events.ics
  def index
    @events = Event.upcoming.order(:start_time)
    @events_cal = Event.ical(@events) if params[:format] == 'ics'
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sync
    if params[:job_id].present?
      job_status = ActiveJobStatus.fetch(params[:job_id])
      status = job_status ? job_status.status : :completed
    else
      params[:job_id] = EventsSyncJob.perform_later.job_id
      status = :queued
    end

    render json: { status: status, job_id: params[:job_id] }
  end

  def async_grid
    @events = Event.upcoming.order(:start_time)
    respond_to do |format|
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def sync_date
    Event.upcoming.last_sync
  end
end
