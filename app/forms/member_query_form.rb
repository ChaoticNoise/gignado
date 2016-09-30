class MemberQueryForm < Reform::Form
  property :trial, default: true
  property :active, default: true
  property :sporadic
  property :on_break
  property :other

  property :patches
  property :bus_drivers
  property :section_leads
end
