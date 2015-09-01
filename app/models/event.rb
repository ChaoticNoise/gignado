class Event < ActiveRecord::Base
  serialize :data, HashSerializer
  
  validates :start_time, :end_time, presence: true
  validate :start_before_end
  
  protected
  def start_before_end
    if start_time > end_time
      errors.add(:end_time, "can't be before the start")
    end
  end
end
