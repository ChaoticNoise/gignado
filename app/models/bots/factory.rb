class Bots::Factory
  @@bot_registry = {
    'slack' => Bots::Slack
  }

  def self.build(bot_name, params = {})
    @@bot_registry[bot_name].new(params)
  end
end
