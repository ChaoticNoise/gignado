require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gignado
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = "Pacific Time (US & Canada)"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.load_defaults 5.1

    config.active_job.queue_adapter = :sucker_punch

    config.autoload_paths << "#{config.root}/app/operations"
    config.autoload_paths << "#{config.root}/app/services"

    # Specifiy Devise layouts
    # (see: https://github.com/plataformatec/devise/wiki/How-To%3a-Create-custom-layouts)
    config.to_prepare do
      Devise::SessionsController.layout proc{ |controller| member_signed_in? ? "application" : "not_signed_in" }
      Devise::RegistrationsController.layout proc{ |controller| member_signed_in? ? "application" : "not_signed_in" }
      Devise::ConfirmationsController.layout proc{ |controller| member_signed_in? ? "application" : "not_signed_in" }
      Devise::UnlocksController.layout proc{ |controller| member_signed_in? ? "application" : "not_signed_in" }
      Devise::PasswordsController.layout proc{ |controller| member_signed_in? ? "application" : "not_signed_in" }
    end
  end
end
