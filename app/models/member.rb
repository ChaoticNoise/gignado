class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]


  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    member = Member.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless member
      member = Member.create(
        first_name: data["first_name"],
        last_name: data["last_name"],
        image_url: data["image"],
        email: data["email"],
        password: Devise.friendly_token[0,20])
    end
    member
  end

  def is_active
    !self.activated_at.nil?
  end

  def is_active=(val)
    self.activated_at = (val.to_i == 1 ? Time.now : nil)
  end
end
