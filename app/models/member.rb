require 'digest/md5'

class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  serialize :data, HashSerializer
  store :data, accessors: [:date_joined, :telephone, :emergency_contact,
    :allergies, :health_issues, :food_restrictions, :pronoun]

  enum status: {trial: 0, active: 1, sporadic: 2, on_break: 3, non_member: 4, officially_quit: 5, unofficially_quit: 6,  failed_trial: 7, suspended: 8, kicked_out: 9}
  enum section: {no_section: 0, percussion: 1, saxophone: 2, trumpet: 3, trombone: 4, sousaphone: 5, bruiser: 6}

  has_many :booker_events, class_name: 'Gig', foreign_key: 'booker_id', dependent: :nullify
  has_many :day_pic_events, class_name: 'Gig', foreign_key: 'day_pic_id', dependent: :nullify
  has_many :gig_pic_events, class_name: 'Gig', foreign_key: 'gig_pic_id', dependent: :nullify
  has_many :bus_pic_events, class_name: 'Gig', foreign_key: 'bus_pic_id', dependent: :nullify
  has_many :rehearsal_pic_events, class_name: 'Rehearsal', foreign_key: 'rehearsal_pic_id', dependent: :nullify

  scope :active, -> { where(status: :active) }
  scope :bus_drivers, -> { where(has_bus_insurance: true) }


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

  def image_url
    read_attribute(:image_url) || gravatar_image_url()
  end

  def gravatar_image_url
    hash = Digest::MD5.hexdigest(self.email.downcase)
    default_style = 'retro'
    "http://www.gravatar.com/avatar/#{hash}?d=#{default_style}"
  end

  def display_name
    [self.first_name, self.last_name].join(" ")
  end

  def access_allowed
    !self.activated_at.nil?
  end

  def access_allowed=(val)
    if val.to_i == 1
      self.activated_at = Time.zone.now
    else
      self.activated_at = nil
    end
  end

  def to_s
    self.display_name.blank? ? self.email : self.display_name
  end
end
