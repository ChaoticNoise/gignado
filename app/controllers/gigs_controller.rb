class GigsController < ApplicationController
  helper_method :gig, :sync_date

  # GET /gigs
  # GET /gigs.json
  # GET /gigs.ics
  def index
    @gigs = Gig.upcoming.order(:start_time)
  end

  # GET /gigs/1
  # GET /gigs/1.json
  def show
  end

  # GET /gigs/new
  def new
    @form = GigForm.new(Gig.new(booker_id: current_member.id))
  end

  # GET /gigs/1/edit
  def edit
    @form = GigForm.new gig
  end

  # POST /gigs
  # POST /gigs.json
  def create
    @form = GigForm.new(Gig.new)

    if @form.validate(params[:gig])
      @form.save
      redirect_to gigs_url, notice: 'Gig was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /gigs/1
  # PATCH/PUT /gigs/1.json
  def update
    @form = GigForm.new gig
    if @form.validate(params[:gig])
      @form.save
      redirect_to gigs_url, notice: 'Gig was successfully updated.'
    else
      render :edit
    end
  end

  def sync
    if params[:job_id].present?
      job_status = ActiveJobStatus.fetch(params[:job_id])
      status = job_status ? job_status.status : :completed
    else
      params[:job_id] = GigsSyncJob.perform_later.job_id
      status = :queued
    end

    render json: { status: status, job_id: params[:job_id] }
  end

  def async_grid
    @gigs = Gig.upcoming.order(:start_time)
    respond_to do |format|
      format.js
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def gig
    @gig ||= Gig.find(params[:id])
  end

  def sync_date
    Gig.upcoming.last_sync
  end
end
