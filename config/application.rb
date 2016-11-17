require_relative 'boot'

require 'rails/all'
require 'net/https'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.initialize_on_precompile = true

    config.active_job.queue_adapter = :sidekiq
    config.action_mailer.perform_deliveries = true
    config.action_mailer.default_url_options = { host: ENV['HOST_URL'] || 'localhost' }
  end
end
