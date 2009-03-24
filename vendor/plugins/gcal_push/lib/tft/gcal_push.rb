$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'base'
require 'calendar'
require 'event'
require 'yaml'
module TFT
  module GcalPush

    def self.included(base) 
      base.extend ActMethods 
    end 

    module ActMethods 
      def pushes_to_gcal( options={} )
        unless included_modules.include? InstanceMethods 
          cattr_accessor :default_calendar
          self.default_calendar = options[:calendar]
          extend ClassMethods 
          include InstanceMethods 
        end# unless
        
        @@options = options
      end # pushes_to_gcal
    end # ActMethods

    module ClassMethods 
    end# ClassMethods

    module InstanceMethods 
      @calendar = nil
      ####################
      #push_to_calendar
      def push_to_calendar( )
        event       = self
        Base.new
        Calendar.get_calendars.each { |c| @calendar = c if c.title == Holiday.default_calendar }
        @calendar ||= Calendar.get_calendars.first
        Event.load( @calendar )
        Event.create( event )        
      end#push_to_calendar
    end# InstanceMethods

  end# GCalPush
end# TFT