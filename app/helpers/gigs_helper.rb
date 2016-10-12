module GigsHelper
  def gig_status_to_icon(status)
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
