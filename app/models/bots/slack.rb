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
    return "" unless authorized?
    case tokenize.first
    when 'all' || 'a'
      format_multi_events(Event.upcoming)
    when 'find' || 'f'
      format_multi_events(Event.search_by(:title, tokenize[1..-1].join(' ')))
    when 'help' || 'h'
      help_response()
    when 'list' || 'l'
      format_multi_events(Event.upcoming.confirmed)
    when 'next' || 'n'
      format_event(Event.upcoming.confirmed.first)
    when 'today' || 't'
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
    r << "  find    find events with query in title"
    r << "  help    displays this help"
    r << "  list    list upcoming confirmed events"
    r << "  next    shows the next confirmed event"
    r << "  today   list confirmed events today"
    r << "```"
    r.join("\n")

  end

  def format_multi_events(events)
    events.map{ |e| format_event(e) }.join("\n")
  end

  def format_event(event)
    return "" if event.nil?
    event.base_url = @base_url
    f = []
    f << event.type.titleize
    f << event.status
    f << event.start_time.strftime("%b %d, %Y %I:%M%P")
    f << "<#{event.url}|#{event.title}>"
    f.join(" | ")
  end

  def tokenize
    @text.split(" ")[1..-1] || []
  end
end
