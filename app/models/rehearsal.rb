class Rehearsal < Event

  enum status: {lets_play: 0, canceled: 2}

  belongs_to :rehearsal_pic, class_name: "Member"

  def title
    _title = "#{self.local_start_time.strftime("%^a %-l:%M%p")} Rehearsal"
    if location.present?
      _title + " @ #{self.location}"
    else
      _title
    end
  end

  def to_s
    self.title
  end

  def start_time
    if self[:start_time]
      self[:start_time]
    else
      self.next_start_time(DateTime.now, Rehearsal.last_date_value(:start_time))
    end
  end

  def next_start_time(date_time_now, last_rehearsal)
    last_date = [date_time_now, last_rehearsal].max
    last_date_was_rehearsal = last_date == last_rehearsal
    last_date_was_not_rehearsal = last_date != last_rehearsal

    if (last_date_was_rehearsal && last_date.wday < 3) || (last_date_was_not_rehearsal && last_date.wday <= 3 && last_date.wday != 0)
      last_date.beginning_of_week(:wednesday) + 1.week + 19.hours + 30.minutes + (last_date_was_rehearsal ? 7.hours : 0)
    else
      last_date.beginning_of_week(:sunday) + 1.week + 19.hours + (last_date_was_rehearsal ? 7.hours : 0)
    end
  end

  def end_time
    if self[:end_time]
      self[:end_time]
    else
      self.start_time + 2.hours
    end
  end

  def location
    if self[:location]
      self[:location]
    else
      "FAIR / FOUL"
    end
  end

end
