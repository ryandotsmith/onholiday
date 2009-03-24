module TFT
  module GcalPush

    class Base

      attr_reader :client

      def initialize
        @@client = GData::Client::Calendar.new
        @@client.clientlogin( 'rsmith@gsenterprises.com','Rs*kc*1986')
      end#initialize  

    end#Base

  end# GCalPush
end# TFT