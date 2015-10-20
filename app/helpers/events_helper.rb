module EventsHelper

  def event_type_to_icon(type)
    type = type.downcase.to_sym
    case type
    when :gig
      'music'
    else
      'exclamation'
    end
  end

  def event_status_to_icon(status)
    status = status.downcase.to_sym
    case status
    when :potential
      'question-circle'
    when :confirmed
      'check-circle'
    when :canceled
      'times-circle'
    else
      'exclamation-circle'
    end
  end
end
