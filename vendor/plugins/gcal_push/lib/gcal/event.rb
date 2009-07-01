module Gcal
  class Event
    attr_accessor :edit_link , :self_link
    def initialize( event )
      @begin_time   = event.begin_time
      @end_time     = event.end_time
      @description  = event.description
      @uid          = event.id
      @user         = event.user.name
    end#initialize

    def self.all( pusher, calendar )
      events  = []
      url = "http://www.google.com/calendar/feeds/#{ pusher.username }/full"
      response = pusher.client.get( calendar.link ).to_xml
      doc = Hpricot( response.to_s)
      (doc/:entry).each do |e|
        # needs fixing. 
        event                 = OpenStruct.new
        event.uid             = (e/'gd:extendedproperty').first
        event.user            = (e/:title).inner_text
        event.edit_link       = (e/:link/"[@rel=edit]").first[:href]    
        event.self_link       = (e/:link/"[@rel=self]").first[:href]
        events << event
      end#do
      events
    end#get_events

    def self.find( pusher, calendar, search_id )
      Event.all( pusher, calendar ).each do |event|
        return event if event.uid = search_id
      end
    end#find

    def to_xml
      re = <<EOF
        <entry xmlns='http://www.w3.org/2005/Atom'
            xmlns:gd='http://schemas.google.com/g/2005'>
          <category scheme='http://schemas.google.com/g/2005#kind'
            term='http://schemas.google.com/g/2005#event'></category>
          <title type='text'>#{ @user }</title>
          <content type='text'>#{ @description }</content>
          <gd:transparency
            value='http://schemas.google.com/g/2005#event.opaque'>
          </gd:transparency>
          <gd:eventStatus
            value='http://schemas.google.com/g/2005#event.confirmed'>
          </gd:eventStatus>
          <gd:when startTime='#{ @begin_time.strftime("%Y-%m-%dT%H:%M:%S") }'
              endTime='#{ @end_time.strftime("%Y-%m-%dT%H:%M:%S") }'></gd:when>
          <gd:extendedProperty name="holiday_id" value="#{ @uid }" />
        </entry>
EOF
    end#make_xml

=begin
    def self.update( event, holiday )
      url = event.edit_link
      xml = Event.make_put_xml( event, holiday )
      response = @@client.put( url, xml )
    end

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
=end

  end#Events
end# GCalPush
