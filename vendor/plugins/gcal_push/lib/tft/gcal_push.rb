$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'base'
require 'calendar'
require 'event'

module TFT
  module GcalPush

    def self.included(base) 
      base.extend ActMethods 
    end 

    module ActMethods 
      def pushes_to_gcal 
        unless included_modules.include? InstanceMethods 
          extend ClassMethods 
          include InstanceMethods 
        end# unless
      end # pushes_to_gcal
    end # ActMethods

    module ClassMethods 
    end# ClassMethods

    module InstanceMethods 
      ####################
      #push_to_calendar
      def push_to_calendar( options={} )
        event = self
        
        Base.new
        #Calendar.get_calendars.each {|c| calendar = c if c == target_cal}
        #calendar ||= Calendar.get_calendars.last
        calendar = Calendar.get_calendars.last
        Event.load( calendar )
        Event.create( event )        
      end#push_to_calendar
    end# InstanceMethods

  end# GCalPush
end# TFT