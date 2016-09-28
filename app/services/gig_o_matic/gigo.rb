class GigOMatic::Gigo < OpenStruct

  def title
    self.gig_title
  end

  def start
    @start ||= _start
  end

  def _start
    date = self.gig_date
    time = [self.gig_call, self.gig_set, "12:00am"].find{|i| i.present?}
    DateTime.strptime("#{date} #{time}", '%m/%d/%Y %l:%M%P')
  rescue
    DateTime.now
  end

  def end
    @end ||= _end
  end

  def _end
    date = [self.gig_enddate, self.gig_date].find{|i| i.present?}
    time = [self.gig_end, "11:59pm"].find{|i| i.present?}
    DateTime.strptime("#{date} #{time}", '%m/%d/%Y %l:%M%P')
  rescue
    DateTime.now
  end

  def details
    self.gig_details
  end

  def location
    self.gig_address
  end

  def status
    self.gig_status.to_i
  end

  def key
    self.gk
  end

end
