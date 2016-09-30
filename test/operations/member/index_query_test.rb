require 'test_helper'

class Member::IndexQueryTest < ActiveSupport::TestCase
  def setup
    @m1 = FactoryGirl.create(:member, status: :trial, has_patch: true)
    @m2 = FactoryGirl.create(:member, status: :active, has_bus_insurance: true)
    @m3 = FactoryGirl.create(:member, status: :sporadic, section_lead: true)
    @m4 = FactoryGirl.create(:member, status: :on_break, has_patch: true)
    @m5 = FactoryGirl.create(:member, status: :non_member, has_bus_insurance: true, section_lead: true)
  end

  test "#members include only trial members" do
    q = Member::IndexQuery.new(trial: "1")
    assert_includes(q.members, @m1)
  end

  test "#members include only trial and active members" do
    q = Member::IndexQuery.new(trial: "1", active: "1")
    assert_includes(q.members, @m1)
    assert_includes(q.members, @m2)
    assert_equal(q.members.count, 2)
  end

  test "#members include only trial and other members" do
    q = Member::IndexQuery.new(trial: "1", other: "1")
    assert_includes(q.members, @m1)
    assert_includes(q.members, @m5)
    assert_equal(q.members.count, 2)
  end

  test "#members include only patch members" do
    q = Member::IndexQuery.new(patches: "1")
    assert_includes(q.members, @m1)
    assert_includes(q.members, @m4)
    assert_equal(q.members.count, 2)
  end

  test "#members include only bus insurance section leads" do
    q = Member::IndexQuery.new(bus_drivers: "1", section_leads: "1")
    assert_includes(q.members, @m5)
    assert_equal(q.members.count, 1)
  end

  test "#members include only on break patch members" do
    q = Member::IndexQuery.new(on_break: "1", patches: "1")
    assert_includes(q.members, @m4)
    assert_equal(q.members.count, 1)
  end
end
