class GigOMatic::Gigo < OpenStruct

  def title
    self.gig_title
  end

  def start
    @start ||= _start
  end

  def _start
    date = self.gig_date
    time = fix_time([self.gig_call, self.gig_set, "12:00am"].find{|i| i.present?})
    offset = "-0800"
    DateTime.strptime("#{date} #{time} #{offset}", '%m/%d/%Y %l:%M%P %z').localtime
  rescue
    Time.zone.now
  end

  def end
    @end ||= _end
  end

  def _end
    date = [self.gig_enddate, self.gig_date].find{|i| i.present?}
    time = fix_time([self.gig_end, "11:59pm"].find{|i| i.present?})
    offset = "-0800"
    DateTime.strptime("#{date} #{time} #{offset}", '%m/%d/%Y %l:%M%P %z').localtime
  rescue
    Time.zone.now
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

  private

  def fix_time(time)
    time = "#{time}am" if !(time =~ /(am|pm)/)
    time
  end

end
