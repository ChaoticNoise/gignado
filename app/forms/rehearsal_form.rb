require "reform/form/coercion"

class RehearsalForm < Reform::Form
  feature Reform::Form::ActiveModel::FormBuilderMethods
  feature Reform::Form::MultiParameterAttributes

  property :status
  property :details
  property :location
  property :start_time, :multi_params => true
  property :end_time, :multi_params => true
  property :rehearsal_pic_id

  validation do
    configure do
      config.messages_file = 'config/error_messages.yml'
      option :form

      def after_start_time?(value)
        form.start_time <= value
      end
    end

    required(:start_time).filled
    required(:end_time).filled(:after_start_time?)
    required(:rehearsal_pic_id).filled
  end
end
