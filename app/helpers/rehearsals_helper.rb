module RehearsalsHelper
  def rehearsal_status_to_icon(status)
    status = status.to_s.downcase.to_sym
    case status
    when :confirmed
      'check-circle'
    when :canceled
      'times-circle'
    else
      'exclamation-circle'
    end
  end
end
