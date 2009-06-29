module TFT
  module GcalPush

    class Base

      cattr_reader :client, :user
      
      def initialize( options={} )
        @@unid            = options[:unid]||= :id
        @@title           = options[:title] ||= :title
        @@description     = options[:description] ||= :description
        @@begin_datetime  = options[:begin_datetime] ||= :begin_datetime
        @@end_datetime    = options[:end_datetime] ||= :end_datetime

        file = File.open("#{RAILS_ROOT}/config/gcal.yml")
        @@gcal_push_config = YAML.load(file)
        @@user = @@gcal_push_config['default']['username']
        password = @@gcal_push_config['default']['password']
        @@client = GData::Client::Calendar.new
        @@client.clientlogin( @@user,password )
      end#initialize  

    end#Base

  end# GCalPush
end# TFT