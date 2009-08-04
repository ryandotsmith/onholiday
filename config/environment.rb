RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.active_record.observers = :holiday_observer
  config.time_zone = 'UTC'
  config.action_controller.session = {
    :session_key => '_onholiday_session',
    :secret      => 'a6e8b35acc74829ed94cc33a345d3922776bde74a1e91609b6bcb3278e2ec671c0d4764457e719cc5535fc2ebb76824ad80921c1b8a640972697d69d2af8c684'
  }
  
  config.gem 'mislav-will_paginate', 
      :version => '~> 2.2.3', 
      :lib => 'will_paginate', 
      :source => 'http://gems.github.com'
  config.gem 'facets',
      :version => '~> 2.5.0'
  config.gem 'daemons'
  config.gem 'sanitize'
end

require 'monkey.rb'
require 'facets/dictionary'
require 'convert_data.rb'

require 'casclient'
require 'casclient/frameworks/rails/filter'
CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://10.0.1.20/"
  )
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(:default => '%m/%d/%Y')
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:default => '%m/%d/%Y')
