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
          cattr_accessor :options
          extend ClassMethods 
          include InstanceMethods 
        end# unless
        self.options = options
      end # pushes_to_gcal
    end # ActMethods

    module ClassMethods 
    end# ClassMethods

    module InstanceMethods 
      @calendar = nil
      ####################
      #push_to_calendar
      def push_to_calendar( )
        event = self
        Base.new( options )
        Calendar.get_calendars.each { |c| @calendar = c if c.title == options[:default_calendar] }
        @calendar ||= Calendar.get_calendars.first
        Event.load( @calendar )
        Event.create( event )        
      end#push_to_calendar
      ####################
      #delete_from_calendar()
      def delete_from_calendar()
        event = self
        Base.new
        Calendar.get_calendars.each { |c| @calendar = c if c.title == Holiday.default_calendar }
        Event.load( @calendar )
        to_be_del = Event.find_by_holiday_id( event.id )
        Event.delete( to_be_del )
      end#delete_from_calendar()
    end# InstanceMethods

  end# GCalPush
end# TFT