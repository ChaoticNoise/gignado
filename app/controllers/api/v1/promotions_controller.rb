class Api::V1::PromotionsController < Api::BaseController

  # GET /v1/promotions.json
  def index
    @promotions = Promotion.upcoming_cached
    render :json => @promotions, :callback => params[:callback]
  end

end
