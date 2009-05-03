module TFT
  module GcalPush

    class Calendar < Base
      attr_accessor :title, :link

      def initialize
        super
        @link   = ""
        @title  = ""
      end

      def self.get_calendars
       calendars = []
       url = "http://www.google.com/calendar/feeds/#{@@user}"
       #url = "http://www.google.com/calendar/feeds/default/allcalendars"
       response = @@client.get( url ).to_xml
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
end# TFT