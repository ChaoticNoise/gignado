require 'test_helper'

class GigTest < ActiveSupport::TestCase
  setup do
    @gig = gigs(:one)
  end

  test "confirmation_deadline returns DateTime object" do
    @gig.confirmation_deadline = {"1":2015,"2":12,"3":26,"4":23,"5":4,"6":10}
    assert @gig.confirmation_deadline.is_a? DateTime
    assert_equal @gig.confirmation_deadline.year, 2015
    assert_equal @gig.confirmation_deadline.month, 12
    assert_equal @gig.confirmation_deadline.day, 26
    assert_equal @gig.confirmation_deadline.hour, 23
    assert_equal @gig.confirmation_deadline.minute, 4
    assert_equal @gig.confirmation_deadline.second, 10
  end
end
