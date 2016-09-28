require 'test_helper'

class Bots::SlackTest < ActiveSupport::TestCase
  def setup
    @bot = Bots::Slack.new(token: 'foo')
    @bot.slack_token = 'foo'
  end

  test "should not authorize when slack token is nil" do
    bot = Bots::Slack.new(token: 'foo')
    refute(bot.authorized?)
  end

  test "should not authorize when slack token is invalid" do
    bot = Bots::Slack.new(token: 'foo')
    bot.slack_token = 'bar'
    refute(bot.authorized?)
  end

  test "should authorize when slack token is valid" do
    bot = Bots::Slack.new(token: 'foo')
    bot.slack_token = 'foo'
    assert(bot.authorized?)
  end

  test "#generate_response should return blank string if not authorized" do
    bot = Bots::Slack.new
    assert_equal(bot.generate_response, "")
  end

  test "#generate_response should return help_response if text is 'gignado'" do
    @bot.text = 'gignado'
    assert_equal(@bot.generate_response, @bot.help_response)
  end

  test "#generate_response should return help_response if text is 'gignado help'" do
    @bot.text = 'gignado help'
    assert_equal(@bot.generate_response, @bot.help_response)
  end

  test "#generate_response should return help_response if text is 'gignado bogus command'" do
    @bot.text = 'gignado bogus command'
    assert_equal(@bot.generate_response, @bot.help_response)
  end

  test "#format_gig should return a formated gig string" do
    gig = FactoryGirl.create(:gig)
    @bot.base_url = "http://foo.test"
    assert_instance_of(String, @bot.format_gig(gig))
  end

  test "#generate_response should return all upcoming gigs if text is 'gignado all'" do
    g1 = FactoryGirl.create(:gig, title: 'Foo', status: :potential)
    g2 = FactoryGirl.create(:gig, title: 'Bar', status: :potential)
    @bot.text = 'gignado all'
    assert(@bot.generate_response.include?(g1.title))
    assert(@bot.generate_response.include?(g2.title))
  end

  test "#generate_response should return found gigs if text is 'gignado find'" do
    g1 = FactoryGirl.create(:gig, title: 'Foo')
    g2 = FactoryGirl.create(:gig, title: 'Bar')
    @bot.text = 'gignado find foo'
    assert(@bot.generate_response.include?(g1.title))
    refute(@bot.generate_response.include?(g2.title))
  end

  test "#generate_response should return confirmed upcoming gigs if text is 'gignado list'" do
    g1 = FactoryGirl.create(:gig, title: 'Foo', status: :confirmed)
    g2 = FactoryGirl.create(:gig, title: 'Bar', status: :potential)
    @bot.text = 'gignado list'
    assert(@bot.generate_response.include?(g1.title))
    refute(@bot.generate_response.include?(g2.title))
  end

  test "#generate_response should return next confirmed gig if text is 'gignado next'" do
    g1 = FactoryGirl.create(:gig, title: 'Foo', status: :potential)
    g2 = FactoryGirl.create(:gig, title: 'Bar', status: :confirmed)
    @bot.text = 'gignado next'
    refute(@bot.generate_response.include?(g1.title))
    assert(@bot.generate_response.include?(g2.title))
  end

  test "#generate_response should return today's confirmed gigs if text is 'gignado today'" do
    g1 = FactoryGirl.create(:gig, title: 'Foo', status: :confirmed, start_time: 1.day.from_now, end_time: 1.day.from_now + 1.hour)
    g2 = FactoryGirl.create(:gig, title: 'Bar', status: :confirmed, confirmation_deadline: Time.zone.today, start_time: Time.zone.today + 1.hour, end_time: Time.zone.today + 2.hour)
    @bot.text = 'gignado today'
    refute(@bot.generate_response.include?(g1.title))
    assert(@bot.generate_response.include?(g2.title))
  end

end
