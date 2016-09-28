require 'test_helper'

class Gig::SyncFromGigoTest < ActiveSupport::TestCase
  def setup
    @gigo = GigOMatic::Gigo.new(
      'gig_title' => 'foo',
      'gig_date' => '1/01/2016',
      'gig_details' => 'details foo',
      'gig_address' => 'address foo',
      'gig_status' => '1',
      'gk' => 'bar'
    )
  end

  test "create a new gig from gigo" do
    Gig::SyncFromGigo.new([@gigo]).update()
    gig = Gig.find_by(gigo_key: @gigo.key)
    assert_equal(gig.title, @gigo.title)
    assert_equal(gig.start_time, @gigo.start)
    assert_equal(gig.end_time, @gigo.end)
    assert_equal(gig.location, @gigo.location)
    assert_equal(Gig.statuses[gig.status], @gigo.status)
    assert_equal(gig.synced_at.day, Time.zone.today.day)
  end

  test "update a gig from gigo" do
    FactoryGirl.create(:gig, gigo_key: @gigo.key, title: 'bar')
    Gig::SyncFromGigo.new([@gigo]).update()

    gig = Gig.find_by(gigo_key: @gigo.key)
    assert_equal(gig.title, @gigo.title)
    assert_equal(gig.start_time, @gigo.start)
    assert_equal(gig.end_time, @gigo.end)
    assert_equal(gig.location, @gigo.location)
    assert_equal(Gig.statuses[gig.status], @gigo.status)
    assert_equal(gig.synced_at.day, Time.zone.today.day)
  end
end
