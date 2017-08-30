require "reform/form/coercion"

class GigForm < Reform::Form
  feature Coercion

  property :title
  property :status
  property :details
  property :location

  property :call_time, type: Types::Form::DateTime
  property :start_time, type: Types::Form::DateTime
  property :end_time, type: Types::Form::DateTime
  property :confirmation_deadline, type: Types::Form::DateTime
  property :multi_day, virtual: true
  property :call_time_display, virtual: true
  property :start_date_display, virtual: true
  property :end_date_display, virtual: true
  property :start_time_display, virtual: true
  property :end_time_display, virtual: true
  property :confirmation_deadline_display, virtual: true
  property :gig_pic_id
  property :day_pic_id
  property :booker_id
  property :bus_pic_id
  property :payment

  validation do
    configure do
      config.messages_file = 'config/error_messages.yml'
      option :form

      def before_set_date?(_)
        form.confirmation_deadline.to_date <= form.start_time.to_date
      end

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

      def before_set_time?(_)
        form.start_time.to_time >= form.call_time.to_time
      end
    end

    required(:title).filled
    required(:start_date_display).filled
    required(:start_time_display).filled
    required(:end_date_display).maybe(:after_set_date?)
    required(:end_time_display).filled(:after_set_time?)
    required(:call_time_display).maybe(:before_set_time?)
    required(:confirmation_deadline_display).maybe(:before_set_date?)
    required(:start_time).filled
    required(:end_time).filled
  end

end
