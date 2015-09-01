require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "validation fails if start time is after end time" do
    gig = FactoryGirl.build(:event, :start_time => Time.now() + 2.hours, :end_time => Time.now() + 1.hour)
    assert !gig.valid?, "Event should not be valid ending before it starts!"
  end
  
  test "converts formats into DateTime properly" do
    e = Event.new
    dt = DateTime.new(2015,8,31,22,32,0)
    assert_equal(dt, e.to_date_time("2015-08-31T22:32:00.000"), "String input should match DateTime")
    assert_equal(dt.utc, e.to_date_time(Time.utc(2015,8,31,22,32,0)), "Time input should match DateTime")
  end
end
