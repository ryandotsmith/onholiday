require File.dirname(__FILE__) + '/../../../../config/boot.rb'
require File.dirname(__FILE__) + '/../../../../config/environment.rb'

require 'fakeweb'
require File.dirname(__FILE__) + "/responses"
# get calendars
FakeWeb.register_uri( :get, "http://www.google.com/calendar/feeds/this.ryansmith@gmail.com", 
                      :body => GET_CALENDAR)
