require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'mime/types'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Worship
  class Application < Rails::Application

    config.generators do |g|


    end

    config.to_prepare do

      Devise::SessionsController.layout "public"
      Devise::RegistrationsController.layout "public"
      Devise::ConfirmationsController.layout "public"
      Devise::UnlocksController.layout "public"
      Devise::PasswordsController.layout "public"

      Dir[File.join(Rails.root, "lib", "auto_html", "filters", "*.rb")].each {|l| require l }


      # Load PublicActivity concerns
      PublicActivity::ORM::ActiveRecord::Activity.send :include, ActivityExtension
    end


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Europe/Paris'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    I18n.config.enforce_available_locales = false

    # config.active_record.raise_in_transactional_callbacks = true

    ActiveSupport.halt_callback_chains_on_return_false = false

  end
end
