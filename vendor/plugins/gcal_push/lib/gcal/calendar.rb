module Gcal
  class Calendar
    attr_accessor :title, :link

    def self.find( client, username, calendar )
      res = Calendar.all( client, username ).select { |h| h.title == calendar }
      return res.first if res.class == Array
      nil
    end

    def self.all( client, username )
     calendars = []
     url = "http://www.google.com/calendar/feeds/#{ username }"
     response = client.get( url ).to_xml
     doc = Hpricot( response.to_s )
     (doc/:entry).each do |entry|
      calendar = Calendar.new
      calendar.title   = (entry/:title).inner_text
      calendar.link   = (entry/:link).first[:href]
      calendars << calendar
     end#do
     calendars
    end#get_calendars

  end#Calendar
end# GCalPush
