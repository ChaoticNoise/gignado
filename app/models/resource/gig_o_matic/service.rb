require 'openssl'
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil

class Resource::GigOMatic::Service

  def initialize
    login
  end

  def agent
    @agent ||= Mechanize.new do |agent|
      agent.verify_mode = OpenSSL::SSL::VERIFY_PEER
      #agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
      agent.follow_meta_refresh = true
      agent.keep_alive = false
      agent.log = Rails.logger
    end
  end

  def login
    agent.get('https://gig-o-matic.appspot.com/login') do |page|
      page.form_with(:action => '/login') do |f|
        f.email = ENV["GIGO_UN"]
        f.password = ENV["GIGO_PW"]
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
      gigo_gig = form.fields.each_with_object({}) { |field, gig|
        gig[field.name] = field.value
      }
      Resource::GigOMatic::Gig.new(gigo_gig)
    }
  end
end
