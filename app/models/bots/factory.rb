class Bots::Factory
  @@bot_registry = {
    'slack' => Bots::Slack
  }

  def self.build(bot_name, params = {})
    p = HashWithIndifferentAccess.new(params)
    @@bot_registry[bot_name].new(p)
  end
end
