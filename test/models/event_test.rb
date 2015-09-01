require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "validation fails if start time is after end time" do
    gig = FactoryGirl.build(:event, :start_time => Time.now() + 2.hours, :end_time => Time.now() + 1.hour)
    assert !gig.valid?, "Event should not be valid ending before it starts!"
  end
end
