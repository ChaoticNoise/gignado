require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "converts formats into DateTime properly" do
    e = Event.new
    dt = DateTime.new(2015,8,31,22,32,0)
    assert_equal(dt, e.to_date_time("2015-08-31T22:32:00.000"), "String input should match DateTime")
    assert_equal(dt.utc, e.to_date_time(Time.utc(2015,8,31,22,32,0)), "Time input should match DateTime")
  end

  test "should make correct ical string" do
    s = DateTime.new(2015,9,1,10,0,0)
    e = s + 1.hour
    title = "TESTYVENT"
    event = Event.new(start_time: s, end_time: e, title: title)
    before_uid = "BEGIN:VEVENT\r\nDTSTAMP:"
    after_uid = "\r\nDTSTART:20150901T100000\r\nDTEND:20150901T110000\r\nSUMMARY:TESTYVENT\r\nEND:VEVENT\r\n"
    output = event.to_ical
    assert(output.start_with?(before_uid), "i_cal string didn't start how I expected: expected #{before_uid}\n\nat beginning of #{output}")
    assert(output.end_with?(after_uid), "i_cal string didn't end how I expected: expected #{after_uid}\n\nat end of #{output}")
    event = event.ical_event
    event.uid = "12341234"
    assert_match(/#{before_uid}\d+T\d+Z\r\nUID:12341234#{after_uid}/, event.to_ical)
  end

  test "event uid should persist" do
    event = FactoryGirl.build(:event)
    uid = event.ical_event.uid
    assert(event.save, "The event should be able to save")
    event = Event.find(event.id)
    assert_equal(uid, event.ical_event.uid)
  end

  test "makes calendar from events" do
    events = [FactoryGirl.build(:gig),FactoryGirl.build(:gig),FactoryGirl.build(:gig),FactoryGirl.build(:gig)]
    ical = Event.ical(events)
    assert_match(/#{events[0].title}/, ical.to_ical)
  end

  test "by_title finds events with words in the column" do
    event = FactoryGirl.create(:event, title: "Some Foo Bar")

    found_event = Event.by_title("Foo").first

    assert_equal(event, found_event)
  end

  test "url returns a url to view the event" do
    event = FactoryGirl.create(:gig)
    event.base_url = "http://test.com"
    assert_equal(event.url, "http://test.com/gigs/#{event.id}")
  end

end
