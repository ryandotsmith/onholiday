$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require File.dirname(__FILE__) + '/gcal/pusher'
require File.dirname(__FILE__) + '/gcal/calendar'
require File.dirname(__FILE__) + '/gcal/event'
require File.dirname(__FILE__) + '/gcal/gdata'

module Gcal
  def self.included(base) 
    # base = ActiveRecord::Base
    # self = Gcal
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
    def load_defaults
      @file = YAML.load( File.open("#{RAILS_ROOT}/config/gcal.yml") )
      @usr  = @file['default']['username']
      @pwd  = @file['default']['password']
      @cal  = options[:calendar]
    end
    ####################
    #push_to_calendar
    def push_to_calendar( calendar=@cal )
      load_defaults
      pusher    = Pusher.new( @usr, @pwd )
      calendar  = Calendar.find( pusher.client, pusher.username, calendar )
      event     = Event.new( self )
      pusher.send_event( calendar, event )
    end#push_to_calendar

    ####################
    #delete_from_calendar()
    def delete_from_calendar( calendar=@cal )
      load_defaults
      pusher    = Pusher.new( @usr, @pwd )
      calendar  = Calendar.find( pusher.client, pusher.username, calendar )
      event     = Event.find( pusher, calendar, self.id )
      pusher.remove_event( event )
    end#delete_from_calendar()
  end# InstanceMethods

end# GCalPush

