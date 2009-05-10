# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec'
require 'spec/rails'

# === for workling 
module Workling
  class Base
    class RailsBase
      def self.register; end
    end
  end
end

worker_path = File.dirname(__FILE__) + "/../app/workers" 
spec_files = Dir.entries(worker_path).select {|x| /\.rb\z/ =~ x}
spec_files -= [ File.basename(__FILE__) ]
spec_files.each { |path| require(File.join(worker_path, path)) }

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
end
