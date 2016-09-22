class Resource::GigOMatic::Gig < OpenStruct

  def title
    self.gig_title
  end

  def start
    date = self.gig_date
    time = [self.gig_call, self.gig_set, "12:00am"].find{|i| i.present?}
    DateTime.strptime("#{date} #{time}", '%m/%d/%Y %l:%M%P')
  end

  def end
    date = [self.gig_enddate, self.gig_date].find{|i| i.present?}
    time = [self.gig_end, "11:59pm"].find{|i| i.present?}
    DateTime.strptime("#{date} #{time}", '%m/%d/%Y %l:%M%P')
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
