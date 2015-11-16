require 'test_helper'

class Bots::FactoryTest < ActiveSupport::TestCase

  test "should return a new slack bot" do
    bot = Bots::Factory.build('slack')
    assert_instance_of(Bots::Slack, bot)
  end
end
