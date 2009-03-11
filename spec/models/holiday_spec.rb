require 'facets/dictionary'

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../factories/holiday_factory')
require File.expand_path(File.dirname(__FILE__) + '/../factories/user_factory')

### Factory :holiday => defaults[ end_time - begin_time == 2.days]

describe "returns an array of holiday types in a specific order" do
# For now, i will specify an array in the model that will hold strings of holidays 
# types. This array will get returned whenever we dealing with a holiday. It should
# be noted that there should be a database column that corresponds to the holiday name
# **ie => if there is a holiday named = whatever. then there should be a database column
# named = whatever_max.

  it "should maintain an ordered array of leave types" do
    Holiday.get_holiday_types.should eql(["etc","personal","vacation"])
    Holiday.get_holiday_types.should_not eql(["etc","vacation","personal"])
  end
  
end

describe "prohibiting time travel " do
  before(:each) do
   dt = DateTime.now
   db = DateTime.now - 1.days
    @holiday = Factory( 
                        :holiday, 
                        :begin_time => dt,
                        :end_time   => dt - 1.days )
  end

  it "should ensure that end date is later than earlier date" do
    @holiday.get_length.should eql( -1 )
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
  
  it "should correctly calculate 2 days of leave " do
    bt  = DateTime.now.beginning_of_day
    @holiday = Factory( 
                        :holiday,
                        :begin_time =>  bt,
                        :end_time   =>  (bt + 1.days)  )
    @holiday.adjust( :not_a_variable )
    @holiday.get_length.should eql( 2 )
  end# it
  
end# end describe

describe "adjust for half or whole days" do
# there is a check box in the new holiday form that will designate 
# the hald day request. The create action of the holidays controller
# will call this method if a hald day is requested.
# likewise for whole days. 

# we can expect that the view form will give us a nil
# value for the end time since the user will not even 
# be presented with a date selector for the end_time.

  before(:each) do
  end

  it "should add 5 hours to the begin date time" do
    @holiday = Factory( 
                        :holiday, 
                        :begin_time => DateTime.now,
                        :end_time   => nil )
    @holiday.adjust("half")
    @holiday.get_length.should eql( 0.5 )
    
  end

  it "should add 24 hours to the current DateTime submitted" do
    @holiday = Factory( 
                        :holiday, 
                        :begin_time => DateTime.now,
                        :end_time   => nil )
    @holiday.adjust("whole")
    @holiday.get_length.should eql( 1 )
    
  end
end #end describe

describe "one holiday per day" do

  it "should not allow multiple holidays on one calendar day" do
    
  end#it

  it "should allow mixed partials" do
    # i use 1/2 day for personal and 1/2 day for sick all on one calendar day

  end#it

end#des

describe "should return specific data sets" do

describe "get holidays statistics for entire universe" do
  
  before(:each) do
    @user_one       = Factory( :user , :login =>  "jbillings")
    @user_two       = Factory( :user , :login =>  "rsmith")

    @holiday_one    = Factory( :holiday, :state => 1, :leave_type => 'etc' ) 
    @holiday_two    = Factory( :holiday, :state => 1, :leave_type => 'etc' ) 
    @holiday_three  = Factory( :holiday, :state => 1, :leave_type => 'etc' ) 
    @holiday_four   = Factory( :holiday, :state => 0, :leave_type => 'etc' ) 

    @user_one.holidays << [ @holiday_one, @holiday_two ]
    @user_two.holidays << [ @holiday_three ]
    
  end
    
    it "calculated used leave days for all users" do
      # even though there are four holidays, this method
      # only returns holidays that have been approved
      # => state == 1 
      Holiday.get_taken_leave.should eql( 6 )
    end#it

    it "calculates available leave for all users" do
      # this is handled by the user model.
    end

    it "returns the ratio of taken / available leave for all users" 
end#desc

