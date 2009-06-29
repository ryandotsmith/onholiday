module Gcal
  class Pusher
    attr_reader :client , :username

    def initialize( username, password )
      @username = username
      @client   = GData::Client::Calendar.new
      @client.clientlogin( username, password )
    end

    def send_event( calendar, event )
      @client.post( calendar.link, event.to_xml )      
    end

    def remove_event( event )
      @client.delete( event.edit_link )
    end

  end
end