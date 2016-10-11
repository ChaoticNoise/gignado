require 'test_helper'

class GigoTest < ActiveSupport::TestCase
  def setup
    @gigo_hash = {
      'gig_title' => 'foo',
      'gig_date' => '1/1/2016',
      'gig_details' => 'details foo',
      'gig_address' => 'address foo',
      'gig_status' => '1',
      'gk' => 'bar'
    }
  end

  test "title returns the gig_title" do
    gigo = GigOMatic::Gigo.new(@gigo_hash)
    assert_equal( gigo.title, @gigo_hash['gig_title'] )
  end

  test "start returns the gig_date" do
    gigo = GigOMatic::Gigo.new(@gigo_hash)
    start_time = gigo.timezone.utc_to_local(gigo.start)
    assert_equal( "#{start_time.month}/#{start_time.day}/#{start_time.year}", @gigo_hash['gig_date'])
  end

  test "start returns now if gig_date is not a date" do
    @gigo_hash['gig_date'] = 'foo'
    gigo = GigOMatic::Gigo.new(@gigo_hash)
    assert_equal(gigo.start.to_s, gigo.timezone.local_to_utc(Time.zone.now).to_s)
  end

  test "end returns the gig_date if no gig_enddate is given" do
    gigo = GigOMatic::Gigo.new(@gigo_hash)
    end_time = gigo.timezone.utc_to_local(gigo.end)
    assert_equal( "#{end_time.month}/#{end_time.day}/#{end_time.year}", @gigo_hash['gig_date'])
  end

  test "end returns now if gig_date is not a date" do
    @gigo_hash['gig_date'] = 'foo'
    gigo = GigOMatic::Gigo.new(@gigo_hash)
    assert_equal(gigo.end.to_s, gigo.timezone.local_to_utc(Time.zone.now).to_s)
  end

  test "details returns the gig_details" do
    gigo = GigOMatic::Gigo.new(@gigo_hash)
    assert_equal( gigo.details, @gigo_hash['gig_details'] )
  end

  test "location returns the gig_address" do
    gigo = GigOMatic::Gigo.new(@gigo_hash)
    assert_equal( gigo.location, @gigo_hash['gig_address'] )
  end

end
