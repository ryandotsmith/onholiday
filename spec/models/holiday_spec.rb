require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../factories/holiday_factory')
### Factory :holiday => defaults[ end_time - begin_time == 2.days]

describe "aduits a holiday" do
  
  it "should adjust for half days" do
    
  end
  
  it "should warn if the request puts user days over max" do
    
  end
  
end


describe "get length of holiday" do
  
  it "should return an integer which represents the number of whole days" do
    dt = DateTime.now
    @holiday = Factory( 
                        :holiday, 
                        :begin_time => dt,
                        :end_time   => dt + 2.days )
    @holiday.get_length.should eql( 2 )
  end# end it 
  
end# end describe

describe "adjust for half days" do
# there is a check box in the new holiday form that will designate 
# the hald day request. The create action of the holidays controller
# will call this method if a hald day is requested.
  before(:each) do
  end

  it "should add 5 hours to the begin date time" do
    @holiday = Factory( 
                        :holiday, 
                        :begin_time => DateTime.now,
                        :end_time   => DateTime.now )
    @holiday.adjust_half_day
    @holiday.get_length.should eql( 0.5 )
    
  end

end #end describe

describe "should return specific data sets" do
  
  it "should get all pending requests" do
    @holiday1 = Factory( :holiday , :state => 0)
    @holiday2 = Factory( :holiday , :state => 1)
    @holiday3 = Factory( :holiday , :state => 0)
    Holiday.get_pending.length.should eql( 2 )
    Holiday.get_pending.include?(@holiday1).should eql( true )
    Holiday.get_pending.include?(@holiday2).should eql( false )
    Holiday.get_pending.include?(@holiday3).should eql( true )
  end
end