require 'test_helper'

class GigTest < ActiveSupport::TestCase
  test "confirmation_deadline should be before the start time" do
    gig = FactoryGirl.build(:gig, start_time: Time.zone.now + 3.hours, end_time: Time.zone.now + 5.hours, confirmation_deadline: Time.zone.now + 4.hours)
    assert !gig.valid?, "shouldn't be valid when confirmation > start"
  end
end
