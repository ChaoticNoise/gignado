class Api::V1::BotsController < Api::BaseController

  # POST /v1/bots/slack.json
  def slack
    params[:base_url] = request.base_url
    bot = Bots::Factory.build('slack', params)
    render json: bot.response.to_json
  end

end
