require 'test_helper'

class GigTest < ActiveSupport::TestCase
  test "confirmation_deadline returns DateTime object" do
    datevals = {year: 2014, month: 12, day: 26, hour: 23, minute: 4, second: 10}
    gig = FactoryGirl.create(:gig, confirmation_deadline: DateTime.new(*datevals.values))
    gig = Gig.find(gig.id)
    assert gig.confirmation_deadline.is_a?(DateTime), "the confirmation deadline should be a DateTime"
    datevals.each do |key, val|
      assert_equal gig.confirmation_deadline.send(key), val, "should get the #{key} I send in"
    end
  end
  
  test "confirmation_deadline should be before the start time" do
    gig = FactoryGirl.build(:gig, start_time: Time.zone.now + 3.hours, end_time: Time.zone.now + 5.hours, confirmation_deadline: Time.zone.now + 4.hours)
    assert !gig.valid?, "shouldn't be valid when confirmation > start"
  end
  
  test "booker saves properly associated with the gig" do
    booker = FactoryGirl.create(:member)
    gig = FactoryGirl.build(:gig, booker: booker)
    assert(gig.valid?, "should be valid with that booker")
    assert(gig.save, "should save with that booker")
    assert_equal(booker.id, gig.booker_id, "The field for booker id should be the id of the booker. And an int")
  end
end
