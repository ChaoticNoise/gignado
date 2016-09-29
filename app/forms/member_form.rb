class MemberForm < Reform::Form
  property :first_name
  property :last_name
  property :email
  property :access_allowed
  property :status
  property :has_patch
  property :section
  property :has_bus_insurance
  property :gigo_key
  property :section_lead

  property :pronoun
  property :date_joined
  property :telephone
  property :emergency_contact

  property :allergies
  property :health_issues
  property :food_restrictions

  validation do
    required(:first_name).filled
    required(:last_name).filled
    required(:email).filled(format?: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end
end
