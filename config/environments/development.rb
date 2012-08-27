MultiDoc::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = false

  config.middleware.use( Oink::Middleware, :instruments => :memory, :logger => Rails.logger )

  # MEMCACHED - Configured in each environment
  # start memcached as daemon "memcached -d -m 128 -l 127.0.0.1 -p 11211"
  memcached_config = YAML.load_file("#{Rails.root.to_s}/config/custom_ymls/memcached.yml")
  config.cache_store = :dalli_store, memcached_config[Rails.env], {
    :expires_after => 600,
    :expires_in => 600,
    :namespace => MultiDoc,
    :compress => true,
    :compress_threshold => 64*1024
  }
  # Save the memcached host/port
  config.after_initialize do
    MEMCACHED.host = memcached_config[Rails.env][0].split(':')[0]
    MEMCACHED.port = memcached_config[Rails.env][0].split(':')[1]
  end
end

Devise.setup do |config|
  config.omniauth :developer
  config.omniauth :ecourts, 'http://ecourts-tr.wicourts.gov', :target => 'multidoc-dsoutha'
end
