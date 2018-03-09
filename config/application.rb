require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Recall
  class Application < Rails::Application
    # Initialize configura tion defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.action_mailer.default_url_options = { host: 'localhost', port:3000 }

    config.filter_parameters << :password
    config.autoload_paths += %W(#{config.root}/app/poros)
    Raven.configure do |config|
  		config.dsn = 'https://25e11499ea134fd38dbf9052d9d51654:0a12cbab351e44fda99f520b46a9bc76@sentry.io/221994'
	end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
