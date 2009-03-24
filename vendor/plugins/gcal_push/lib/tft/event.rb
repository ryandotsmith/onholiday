module TFT
  module GcalPush
    class Event < Base
  
      attr_accessor :holiday_id, :title, :description, :edit_link, :self_link
  
      def initialize()
        @holiday_id   = ""
        @title        = ""
        @description  = ""
        @edit_link    = ""
        @self_link    = ""
        super()
      end#initialize

      def self.load( calendar )
        @@calendar = calendar
      end

      def self.create( holiday )
        url       = @@calendar.link
        xml       = self.make_post_xml( holiday )
        response  = @@client.post( url, xml )
      end

      def self.update( event, holiday )
        url = event.edit_link
        xml = Event.make_put_xml( event, holiday )
        response = @@client.put( url, xml )
      end
  
      def self.delete( event )
        url = event.edit_link
        response = @@client.delete( url )
      end

      def self.get_events
        events  = []
        id = @@calendar.link
        url = "http://www.google.com/calendar/feeds/#{@@user}/full"
        response = @@client.get( id ).to_xml
        doc = Hpricot( response.to_s)
        (doc/:entry).each do |e|
          # needs fixing. 
          event   = Event.new
          event.holiday_id      = (e/'gd:extendedproperty').first
          event.title           = (e/:title).inner_text
          event.edit_link       = (e/:link/"[@rel=edit]").first[:href]    
          event.self_link       = (e/:link/"[@rel=self]").first[:href]
          events << event
        end#do
        events
      end#get_events

      def self.find_by_holiday_id( holiday_id )
        Event.get_events.each do |event|
          return event if event.holiday_id = holiday_id
        end
      end#find_by_holiday_id

      def self.make_put_xml( event, holiday )
      rere = <<EOF

      <entry xmlns='http://www.w3.org/2005/Atom' 
             xmlns:gd='http://schemas.google.com/g/2005' 
             xmlns:gCal='http://schemas.google.com/gCal/2005'
             gd:etag='FkkOQgZGeip7ImA6WhVR'>
        <id>#{ event.self_link }</id>
        <published>#{ event.created_at.xmlschema }</published>
        <updated>#{ DateTime.now }</updated>
        <category scheme='http://schemas.google.com/g/2005#kind'
          term='http://schemas.google.com/g/2005#event'></category>
        <title type='text'>#{ event.user_name }</title>
        <content type='text'>#{ event.description }</content>
        <gd:transparency
          value='http://schemas.google.com/g/2005#event.opaque'>
        </gd:transparency>
        <gd:eventStatus
          value='http://schemas.google.com/g/2005#event.confirmed'>
        </gd:eventStatus>
        <gd:when startTime='#{ event.begin_time.xmlschema }'
          endTime='#{ event.end_time.xmlschema }'>
        </gd:when>
      </entry>
EOF
      end


      def self.make_post_xml( event )
        rere = <<EOF
          <entry xmlns='http://www.w3.org/2005/Atom'
              xmlns:gd='http://schemas.google.com/g/2005'>
            <category scheme='http://schemas.google.com/g/2005#kind'
              term='http://schemas.google.com/g/2005#event'></category>
            <title type='text'> #{ event.user.name } </title>
            <content type='text'>#{ event.description }</content>
            <gd:transparency
              value='http://schemas.google.com/g/2005#event.opaque'>
            </gd:transparency>
            <gd:eventStatus
              value='http://schemas.google.com/g/2005#event.confirmed'>
            </gd:eventStatus>
            <gd:when startTime='#{ event.begin_time.strftime("%Y-%m-%dT%H:%M:%S") }'
                endTime='#{ event.end_time.strftime("%Y-%m-%dT%H:%M:%S") }'></gd:when>
            <gd:extendedProperty name="holiday_id" value="#{ event.id }" />
          </entry>
EOF
      end#make_xml

    end#Events
  end# GCalPush
end# TFT
