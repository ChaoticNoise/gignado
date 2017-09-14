require "reform/form/coercion"

class PromotionForm < Reform::Form
  feature Coercion

  property :title
  property :url
  property :location_display
  property :event_id
  property :location_url
  property :time_display

  validation do
    configure do
      config.messages_file = 'config/error_messages.yml'
      option :form
    end

    required(:title).filled
    required(:location_display).filled
    required(:time_display).filled
  end
end
