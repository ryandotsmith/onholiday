require 'rubygems'
require 'yaml'
module UpTheData
  class Convert
    def self.scrub_holidays
      half,whole,errors = 0,0,0
      holidays = Holiday.find(:all)
      holidays.each do |holiday|
        user = User.find( holiday.user_id )
        if ((holiday.end_time.to_datetime - holiday.begin_time.to_datetime).to_f.round) < 1
          type = 'half'
          half += 1
        else
          type = 'whole'
          whole += 1
        end
        holiday.update_hook(type)
        if holiday.save!
          begin 
            holiday.push_to_calendar
          rescue 
            errors += 1
          end
        end# if
      end#do      
      { :holidays => holidays.length , :whole => whole, :half => half, :errors => errors }
      end#def
      ####################
      #delete_events
      def self.delete_events
        TFT::GcalPush::Base.new
        c = TFT::GcalPush::Calendar.get_calendars.last
        TFT::GcalPush::Event.load(c)
        e = TFT::GcalPush::Event.get_events
        e.each do |ev|
          TFT::GcalPush::Event.delete( ev )
        end
      end#delete_events
  end#Convert
end#UpTheData