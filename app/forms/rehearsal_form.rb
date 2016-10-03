require "reform/form/coercion"

class RehearsalForm < Reform::Form
  feature Coercion

  property :status
  property :details
  property :location
  property :start_time, type: Types::Form::DateTime
  property :end_time, type: Types::Form::DateTime
  property :rehearsal_pic_id
  property :date, virtual: true
  property :start_time_display, virtual: true
  property :end_time_display, virtual: true

  validation do
    configure do
      config.messages_file = 'config/error_messages.yml'
      option :form

      def after_start_time?(value)
        form.start_time <= form.end_time
      end
    end

    required(:date).filled
    required(:start_time_display).filled
    required(:end_time_display).filled(:after_start_time?)
    required(:rehearsal_pic_id).filled
  end

end
