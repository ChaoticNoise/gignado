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
  property :password, default: Devise.friendly_token[0,20]

  property :pronoun
  property :date_joined
  property :telephone
  property :emergency_contact

  property :allergies
  property :health_issues
  property :food_restrictions

  validation do
    configure do
      config.messages_file = 'config/error_messages.yml'
      option :form

      def email_unique?(_)
        Member.where.not(id: form.model.id).find_by(email: form.email).nil?
      end
    end

    required(:first_name).filled
    required(:last_name).filled
    required(:email).filled(format?: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    required(:email).filled(:email_unique?)
  end
end
