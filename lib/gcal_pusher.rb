class GcalPusher < Struct.new(:holiday_id)
  def perform
    holiday = Holiday.find(holiday_id)    
    holiday.push_to_calendar
  end
end
