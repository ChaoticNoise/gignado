class Api::V1::BotsController < Api::BaseController

  # GET /bots/:bot.json
  def show
    params[:base_url] = request.base_url
    bot = Bots::Factory.build(params[:id], params)
    render json: bot.response.to_json
  end
end
