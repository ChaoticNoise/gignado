class GigsController < ApplicationController
  before_action :set_gig, only: [:show, :edit, :update, :destroy]

  helper_method :sync_date

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
    @gig = Gig.new
  end

  # GET /gigs/1/edit
  def edit
  end

  # POST /gigs
  # POST /gigs.json
  def create
    @gig = Gig.new(gig_params)

    respond_to do |format|
      if @gig.save
        format.html { redirect_to @gig, notice: 'Gig was successfully created.' }
        format.json { render :show, status: :created, location: @gig }
      else
        format.html { render :new }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gigs/1
  # PATCH/PUT /gigs/1.json
  def update
    respond_to do |format|
      if @gig.update(gig_params)
        format.html { redirect_to @gig, notice: 'Gig was successfully updated.' }
        format.json { render :show, status: :ok, location: @gig }
      else
        format.html { render :edit }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gigs/1
  # DELETE /gigs/1.json
  def destroy
    @gig.destroy
    respond_to do |format|
      format.html { redirect_to gigs_url, notice: 'Gig was successfully destroyed.' }
      format.json { head :no_content }
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
  def set_gig
    @gig = Gig.find(params[:id])
  end

  def sync_date
    Gig.upcoming.last_sync
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def gig_params
    params.require(:gig).permit(:title, :status, :start_time, :end_time,
    :location, :details, :confirmation_deadline, :play_times, :payment,
    :payment_status, :plus_ones_allowed, :merch_needs)
  end
end
