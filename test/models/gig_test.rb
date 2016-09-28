require 'test_helper'

class GigTest < ActiveSupport::TestCase
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

  test ".last_sync returns last gig synced_at date" do
    expected = DateTime.now - 10.days
    FactoryGirl.create(:gig, synced_at: nil)
    FactoryGirl.create(:gig, synced_at: expected)
    FactoryGirl.create(:gig, synced_at: DateTime.now)

    assert_equal(Gig.last_sync.to_i, expected.to_i)
  end

end
