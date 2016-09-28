require 'openssl'
class GigOMatic::Service

  def initialize
    login
  end

  def gigs
    # Don't sync to gigo if running tests
    if Rails.env.test?
      []
    else
      gig_forms.map { |form|
        gigo_gig = form.fields.each_with_object({}) { |field, gig|
          gig[field.name] = field.value
        }
        GigOMatic::Gigo.new(gigo_gig)
      }
    end
  end

  private

  def agent
    @agent ||= Mechanize.new do |agent|
      agent.verify_mode = OpenSSL::SSL::VERIFY_PEER
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

end
