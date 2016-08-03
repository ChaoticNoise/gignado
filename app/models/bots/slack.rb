class Bots::Slack

  attr_writer :slack_token, :token, :channel_name, :user_name, :text,
    :trigger_word, :base_url

  def initialize(params = {})
    @token          = params[:token]
    @channel_name   = params[:channel_name]
    @user_name      = params[:user_name]
    @text           = params[:text] || ""
    @trigger_word   = params[:trigger_word]
    @base_url       = params[:base_url]
  end

  def authorized?
    Rails.logger.error("Bots::Slack => Environment variable SLACK_TOKEN not found.") if slack_token.blank?
    slack_token.present? && @token == slack_token
  end

  def slack_token
    @slack_token ||= ENV["SLACK_TOKEN"]
  end

  def response
    { text: generate_response() }
  end

  def generate_response
    t = tokenize.first

    if !authorized?
      return ""
    elsif t == 'all' || t == 'a'
      format_multi_events(Event.upcoming)
    elsif t ==  'find' || t == 'f'
      format_multi_events(Event.search_by(:title, tokenize[1..-1].join(' ')))
    elsif t == 'help' || t == 'h'
      help_response()
    elsif t == 'list' || t == 'l'
      format_multi_events(Event.upcoming.confirmed)
    elsif t ==  'next' || t == 'n'
      format_event(Event.upcoming.confirmed.first)
    elsif t == 'today' || t == 't'
      format_multi_events(Event.today.confirmed)
    else
      help_response()
    end
  end

  def help_response
    r = []
    r << "```"
    r << "gignado <command>"
    r << "  all     all upcoming events"
    r << "  find    find by events title"
    r << "  help    displays this help"
    r << "  list    upcoming confirmed events"
    r << "  next    next confirmed event"
    r << "  today   confirmed events today"
    r << "```"
    r.join("\n")
  end

  def type_icon(type)
    case type
    when 'Gig'
      ':musical_note:'
    else
      type
    end
  end

  def status_icon(status)
    case status
    when 'potential'
      ':grey_question:'
    when 'canceled'
      ':x:'
    when 'confirmed'
      ':white_check_mark:'
    else
      status
    end
  end

  def format_multi_events(events)
    events.map{ |e| format_event(e) }.join("\n")
  end

  def format_event(event)
    return "" if event.nil?
    event.base_url = @base_url
    f = []
    f << type_icon(event.type)
    f << status_icon(event.status)
    f << event.start_time.strftime("%b %d, %Y %I:%M%P")
    f << "<#{event.url}|#{event.title}>"
    if event.location.present?
      location_query = { q: event.location }.to_query
      f << "<https://maps.google.com?#{location_query}|map>"
    end
    f.join(" | ")
  end

  def tokenize
    @tokenize ||= @text.split(" ")[1..-1] || []
  end
end