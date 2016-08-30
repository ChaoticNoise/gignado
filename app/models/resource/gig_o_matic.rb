require 'openssl'
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil

class Resource::GigOMatic

  def initialize
  end

  def agent
    @agent ||= Mechanize.new do |agent|
      agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
      agent.follow_meta_refresh = true
      agent.keep_alive = false
      agent.log = Rails.logger
    end
  end

  def login
    agent.get('https://gig-o-matic.appspot.com/login') do |page|
      page.form_with(:action => '/login') do |f|
        f.email = 'dvantuyl@gmail.com'
        f.password = 'ZeVocHstp5mw'
      end.submit
    end
  end

  def agenda
    agent.get('https://gig-o-matic.appspot.com/agenda.html') do |page|
      page.links.each do |link|
        puts link.text
      end
    end
  end
end
