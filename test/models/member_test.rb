require 'test_helper'

class MemberTest < ActiveSupport::TestCase

  test "#access_allowed= 1 sets activated_at" do
    member = FactoryGirl.create(:member)
    member.access_allowed = 1
    member.save!

    assert member.activated_at.kind_of? Time
  end

  test "#access_allowed= 0 nils activated_at" do
    member = FactoryGirl.create(:member)
    member.access_allowed = 0
    member.save!

    assert member.activated_at.nil?
  end
end
