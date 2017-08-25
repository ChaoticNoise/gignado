require 'test_helper'

class PromotionTest < ActiveSupport::TestCase
  test "event saves properly associated with the promotion" do
    event = FactoryGirl.create(:event)
    promotion = FactoryGirl.build(:promotion, event: event)
    assert(promotion.valid?, "should be valid with that event")
    assert(promotion.save, "should save with that event")
    assert_equal(event.id, promotion.event_id, "The field for event id should be the id of the event. And an int")
  end

  test "#new_from_event copies event data" do
    event = FactoryGirl.create(:event)
    promotion = Promotion.new_from_event(event)

    assert_equal(promotion.event_id, event.id)
    assert_equal(promotion.title, event.title)
    assert_equal(promotion.location_display, event.location)
    assert_equal(promotion.location_url, event.location_url)
    assert_equal(promotion.start_time, event.start_time)
    assert_equal(promotion.end_time, event.end_time)
  end
end
