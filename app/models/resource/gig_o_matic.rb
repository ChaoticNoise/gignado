require 'openssl'
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil

class Resource::GigOMatic

  def initialize
    login
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

  def gig_forms
    agent.get('https://gig-o-matic.appspot.com/agenda.html')
      .links_with(href: /gig_info\.html/)
      .map {|link| agent.get(link.href.gsub('gig_info','gig_edit')).form }
  end

  def gigs
    gig_forms.map { |form|
      form.fields.inject({}) { |gig, field|
        gig[field.name] = field.value
        gig
      }
    }
  end
end
