require 'rubygems'
class HolidayWorker < Workling::Base 
  ####################
  #publish
  def publish( options )
    holiday = Holiday.find( options[:holiday_id] )
    user    = User.find( options[:user_id])
    holiday.approve( user )
  end#publish
end