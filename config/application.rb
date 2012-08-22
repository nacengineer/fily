require File.expand_path('../boot', __FILE__)
require File.expand_path('../boot', __FILE__)

# require 'rails/all'
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "rails/test_unit/railtie"
require "sprockets/railtie"


if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  #Bundler.require *Rails.groups(:assets => %w(development test dsoutha))
  #Bundler.require *Rails.groups(:development => %w(dsoutha))
  # If you want your assets lazily compiled in production, use this line
  Bundler.require(:default, :assets, :ccap, Rails.env)
end

# require 'will_paginate/data_mapper'

# Set the default date format to MM/DD/YYYY
Date::DATE_FORMATS[:default] = "%m/%d/%Y"

module MultiDoc
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'America/Chicago'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

   # Enable the asset pipeline
    config.assets.enabled = true
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.generators do |g|
      g.fixture_replacement :factory_girl
      g.form_builder :simple_form
      g.template_engine :haml
    end

    # MEMCACHED - Configured in each environment
    # start memcached as daemon "memcached -d -m 128 -l 127.0.0.1 -p 11211"
    dir = "#{Rails.root.to_s}/config/custom_ymls/memcached.yml"
    memcached_config = YAML.load_file( dir )
    config.cache_store = :dalli_store, memcached_config[Rails.env], {
      :expires_after => 600,
      :expires_in => 600,
      :namespace => MultiDoc,
      :compress => true,
      :compress_threshold => 64*1024
    }

    # Save the memcached host/port
    config.after_initialize do
      begin
        raise ArgumentError unless memcached_config.has_key?(Rails.env)
        MEMCACHED.host = memcached_config[Rails.env][0].split(':')[0]
        MEMCACHED.port = memcached_config[Rails.env][0].split(':')[1]
      rescue ArgumentError
        raise "There is no such Rails environment in memcached file (#{dir})"
      end
    end

  end
end
