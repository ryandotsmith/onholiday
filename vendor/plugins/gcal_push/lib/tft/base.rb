module TFT
  module GcalPush

    class Base

      attr_reader :client

      def initialize
        file = File.open("#{RAILS_ROOT}/config/gcal.yml")
        @@gcal_push_config = YAML.load(file)
        user = @@gcal_push_config['default']['username']
        password = @@gcal_push_config['default']['password']
        @@client = GData::Client::Calendar.new
        @@client.clientlogin( user,password )
      end#initialize  

    end#Base

  end# GCalPush
end# TFT