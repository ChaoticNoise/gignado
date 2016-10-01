class Rehearsal < Event

  enum status: {lets_play: 0, canceled: 2}
  
  belongs_to :rehearsal_pic, class_name: "Member"


end
