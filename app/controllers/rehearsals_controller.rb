class RehearsalsController < ApplicationController

  helper_method :rehearsal

  def index
    @rehearsals = Rehearsal.upcoming.order(:start_time)
  end

  def show
  end

  def new
    @form = RehearsalForm.new(Rehearsal.new)
  end

  def edit
    @form = RehearsalForm.new(rehearsal)
  end

  def create
    @form = RehearsalForm.new(Rehearsal.new)
    if @form.validate(params[:rehearsal])
      @form.save
      redirect_to rehearsals_url, notice: 'Rehearsal was successfully created.'
    else
      render :new
    end
  end

  def update
    @form = RehearsalForm.new(rehearsal)
    if @form.validate(params[:rehearsal])
      @form.save
      redirect_to rehearsals_url, notice: 'Rehearsal was successfully updated.'
    else
      render :edit
    end
  end

  private

  def rehearsal
    @rehearsal ||= Rehearsal.find(params[:id])
  end
end
