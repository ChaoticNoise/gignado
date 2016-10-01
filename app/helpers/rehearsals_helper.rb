module RehearsalsHelper
  def rehearsal_status_to_icon(status)
    status = status.downcase.to_sym
    case status
    when :lets_play
      'check-circle'
    when :canceled
      'times-circle'
    else
      'exclamation-circle'
    end
  end
end
