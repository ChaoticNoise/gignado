require 'test_helper'

class MemberTest < ActiveSupport::TestCase

  test "#is_active= 1 sets activated_at" do
    member = FactoryGirl.create(:member)
    member.is_active = 1
    member.save!

    assert member.activated_at.kind_of? Time
  end

  test "#is_active= 0 nils activated_at" do
    member = FactoryGirl.create(:member)
    member.is_active = 0
    member.save!

    assert member.activated_at.nil?
  end
end
