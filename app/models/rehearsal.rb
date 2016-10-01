class Rehearsal < Event

  enum status: {lets_play: 0, canceled: 2}

  belongs_to :rehearsal_pic, class_name: "Member"

  def title
    "#{self.start_time.strftime("%^a")} Rehearsal @ #{self.location}"
  end

  def to_s
    self.title
  end

end
