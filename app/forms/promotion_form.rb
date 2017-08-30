require "reform/form/coercion"

class PromotionForm < Reform::Form
  feature Coercion

  property :title
  property :url
  property :details
  property :location_display
  property :event_id
  property :location_url
  property :start_time, type: Types::Form::DateTime
  property :end_time, type: Types::Form::DateTime
  property :multi_day, virtual: true
  property :time_display
  property :start_date_display, virtual: true
  property :end_date_display, virtual: true
  property :start_time_display, virtual: true
  property :end_time_display, virtual: true

  validation do
    configure do
      config.messages_file = 'config/error_messages.yml'
      option :form

      def after_set_date?(_)
        form.start_time.to_date <= form.end_time.to_date
      end

      def after_set_time?(_)
        if form.start_time.to_date == form.end_time.to_date
          form.start_time.to_time <= form.end_time.to_time
        else
          true
        end
      end
    end

    required(:title).filled
    required(:location_display).filled
    required(:end_date_display).maybe(:after_set_date?)
    required(:end_time_display).filled(:after_set_time?)
    required(:start_time).filled
    required(:time_display).filled
  end
end
