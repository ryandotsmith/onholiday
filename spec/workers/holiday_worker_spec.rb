require File.dirname(__FILE__) + '/../spec_helper'

describe HolidayWorker do

  it "should send a holiday to google calendar" do
    Holiday.should_receive(:find).and_return(@holiday = mock_model(Holiday))
    @holiday.should_receive(:push_to_calendar)
    HolidayWorker.asynch_publish( :holiday_id => 1, :user_id => 1) 
  end


end