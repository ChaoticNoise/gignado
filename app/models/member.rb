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
      user = User.create(name: data["name"],
                        email: data["email"],
                        password: Devise.friendly_token[0,20])
    end
    member
  end
end
