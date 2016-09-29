class MemberQueryForm < Reform::Form
  property :trial
  property :active
  property :sporadic
  property :on_break
  property :all

  property :patch
  property :bus_drivers
  property :section_lead
end
