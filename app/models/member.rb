require 'digest/md5'

class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :booker_events, class_name: 'Event', foreign_key: 'booker_id', dependent: :nullify
  has_many :day_pic_events, class_name: 'Event', foreign_key: 'day_pic_id', dependent: :nullify
  has_many :gig_pic_events, class_name: 'Event', foreign_key: 'gig_pic_id', dependent: :nullify
  has_many :bus_pic_events, class_name: 'Event', foreign_key: 'bus_pic_id', dependent: :nullify
  has_many :rehearsal_pic_events, class_name: 'Event', foreign_key: 'rehearsal_pic_id', dependent: :nullify


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
    self.first_name
  end

  def is_active
    !self.activated_at.nil?
  end

  def is_active=(val)
    self.activated_at = (val.to_i == 1 ? Time.now : nil)
  end

  def to_s
    self.display_name.blank? ? self.email : self.display_name
  end
end
