class PromotionsController < ApplicationController
  helper_method :promotion

  # GET /events/1/promotions/new
  def new
    @form = PromotionForm.new(Promotion.new_from_event(event))
  end

  # GET /promotions/1/edit
  def edit
    @form = PromotionForm.new promotion
  end

  # POST /promotions
  def create
    @form = PromotionForm.new(Promotion.new)

    if @form.validate(params[:promotion])
      @form.save
      redirect_to gigs_url, notice: 'Promo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /promotions/1
  def update
    @form = PromotionForm.new promotion
    if @form.validate(params[:promotion])
      @form.save
      redirect_to gigs_url, notice: 'Promo was successfully updated.'
    else
      render :edit
    end
  end

  private

  def promotion
    @promotion ||= Promotion.find(params[:id])
  end

  def event
    @event ||= Event.find(params[:event_id])
  end
end