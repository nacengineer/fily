source "http://gems.wicourts.gov"
source 'http://rubygems.org'

RAILS_VERSION = '~> 3.2.0'
DM_VERSION    = '~> 1.2.0'

gem 'actionmailer',         RAILS_VERSION
gem 'activeresource',       RAILS_VERSION
gem 'rake'
gem 'pg'

# datamapper for connecting to postgres
# sqlite for quick one off database needs. eg testing
gem 'dm-core',              DM_VERSION
gem 'dm-rails',             DM_VERSION
gem 'dm-aggregates',        DM_VERSION
gem 'dm-observer',          DM_VERSION
gem 'dm-postgres-adapter',  DM_VERSION
gem 'dm-migrations',        DM_VERSION
gem 'dm-do-adapter',        DM_VERSION
gem 'dm-sqlite-adapter',    DM_VERSION
gem 'dm-validations',       DM_VERSION
gem 'dm-timestamps',        DM_VERSION
gem 'dm-ar-finders',        DM_VERSION
gem 'dm-constraints',       DM_VERSION
gem 'dm-types',             DM_VERSION
gem 'dm-serializer',        '~> 1.2.1'
gem 'dm-devise',            '~> 2.1.0'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',         '~> 3.2.3'
  gem 'bootstrap-sass',     '~> 2'
  gem 'coffee-rails'
  gem 'uglifier',           '~>1.0.3'
  gem 'compass-rails'
  gem 'jquery-ui-themes',   '~> 0.0.5'
end

gem 'carrierwave-datamapper', :require => 'carrierwave/datamapper'
gem 'country_select', '1.0', :git => 'git@gitlab.wicourts.gov:country_select.git'
gem 'mini_magick'
gem 'fog',                  '~> 1.3.1'
gem 'simple_form'
gem 'haml-rails'
gem 'jquery-rails'
gem 'json'
gem 'dalli'

group :ccap do
  gem 'omniauth',           '~> 1.0.2'
  gem 'omniauth-ecourts',   '~> 1.0.2'
  gem 'for11',              '~> 0.2'
end

group :development do
  # gem 'pry-rails'
  gem 'annotate'
  gem 'silent-postgres'
  gem 'awesome_print'
  gem 'rails3-generators'
  gem 'oink'
  gem 'hirb'
  gem 'ruby-prof'
  gem 'thin'
  gem 'brahma', :require => false
end

group :test do
  # Pretty printed test output
  gem 'turn',               '~>0.8.3', :require => false
  # gem 'ruby-debug19' , :require => 'ruby-debug'
  gem 'simplecov'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'ZenTest'
  gem 'autotest-rails'
  gem 'metrical'
  gem 'pry'
  gem 'forgery'
  gem 'sqlite3'
end

group :linux_test do
  gem 'test_notifier'
  gem 'rb-inotify'
  gem 'libnotify'
end

group :production do
  # Use unicorn as the web server
  gem 'trinidad'
end

