class CalendarController < ApplicationController
  def index
    @array = []
    cal = Icalendar::Calendar.new
    Holiday.approved.each do |holiday|
      cal.event do
        dtstart      holiday.begin_time.to_datetime
        dtend        holiday.end_time.to_datetime
        summary      "#{holiday.leave_length} - #{holiday.user.name}"
        description  holiday.description
      end
      @array << cal
    end
    respond_to do |wants|
      wants.html { render :text => @array.to_ical } 
    end
  end
end
