require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "creating a holiday" do
  before(:each) do
    @user     = Factory( :user )
    @dt       = MONDAY
  end#before
  
  describe "scrubbing the input" do
    it "should sanitize the description" do
      holiday = Factory.build( :holiday, :description => "&& bad" )
      holiday.description.should == "&& bad"
      holiday.save
      holiday.description.should == "&amp;&amp; bad"
    end
  end
  
  describe "creating half day" do

    it "should save when nothing is wrong" do
      holiday = Factory.build(  :holiday,  
                                :leave_length => 'half',
                                :user => @user, 
                                :begin_time => MONDAY,
                                :end_time   => nil)
      holiday.save.should eql( true )      
    end# it

    it "should fail when days in holiday are already covered by existing holiday" do
      holiday = Factory.build(  :holiday, 
                                :leave_length => 'half',
                                :user => @user, 
                                :begin_time => @dt,
                                :end_time   => nil)
      holiday.save.should eql( true )      

      bad_holiday = Factory.build( :holiday, 
                                    :leave_length => 'whole',
                                    :user => @user, 
                                    :begin_time => @dt,
                                    :end_time   => nil)
      bad_holiday.should_not be_valid
      bad_holiday.save.should eql( false )            
    end
    it "should fail when half day falls into existing range of holidays" do
      holiday = Factory(  :holiday, 
                          :leave_length => 'many',
                          :user => @user, 
                          :begin_time => @dt,
                          :end_time   => @dt + 4.days)

      bad_holiday = Factory.build(  :holiday, 
                                    :leave_length => 'whole',
                                    :user => @user, 
                                    :begin_time => @dt + 2.days,
                                    :end_time   => nil)
      bad_holiday.should_not be_valid
      bad_holiday.save.should eql( false )            
      
    end
    
  end# half day

  describe "creating a whole day" do
    
  end# whole day

  describe "creatinga range of days" do
    
  end# range day

end#des

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
  @holiday = Factory.build( :holiday, 
                            :begin_time => DateTime.now, 
                            :end_time   => DateTime.now - 2.days )
  end

  it "should ensure that end date is later than earlier date" do
    @holiday.should_not be_valid
    @holiday.get_length.should eql( 0.0 )
  end

end

describe "get length of holiday" do
  
  it "should return an float which represents the number of whole days" do
    dt = MONDAY
    @holiday = Factory( 
                        :holiday, 
                        :begin_time => dt,
                        :end_time   => dt + 1.days )
    @holiday.get_length.should eql( 2.0 )
  end# end it 

  it "should correctly calculate 1 day of leave " do
    bt  = MONDAY
    @holiday = Factory( 
                        :holiday,
                        :begin_time =>  bt,
                        :end_time   =>  bt  )
    @holiday.get_length.should eql( 1.0 )
    
  end
  it "should correctly calculate 2 days of leave " do
    bt  = MONDAY
    @holiday = Factory( 
                        :holiday,
                        :leave_length => 'many',
                        :begin_time =>  bt,
                        :end_time   =>  bt + 1.days )  
    @holiday.get_length.should eql( 2.0 )
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
    @holiday = Factory(       :holiday, 
                              :leave_length => 'half',
                              :begin_time => DateTime.now,
                              :end_time   => nil )
    # have to override the before_save method to make a half day save
    @holiday.get_length.should eql( 0.5 )
    
  end

  it "should add 24 hours to the current DateTime submitted" do
    @holiday = Factory( 
                        :holiday, 
                        :leave_length => 'whole',
                        :begin_time => DateTime.now,
                        :end_time   => nil )
    @holiday.get_length.should eql( 1.0 )
    
  end
end #end describe

describe "should return specific data sets" do

    describe "get holidays statistics for entire universe" do
    before(:each) do      
      date = MONDAY
      @user_one       = Factory( :user , :login =>  "jbillings")
      @user_two       = Factory( :user , :login =>  "jhoover")

      # 3 days
      @holiday_one    = Factory(  :holiday, 
                                  :leave_length  => 'many',
                                  :state => 1, 
                                  :leave_type => 'etc', 
                                  :user => @user_one,
                                  :begin_time => date,
                                  :end_time   => date + 2.days) 
      # 3 days
      @holiday_two    = Factory(  :holiday, 
                                  :leave_length  => 'many',
                                  :state => 1, 
                                  :leave_type => 'etc', 
                                  :user => @user_one, 
                                  :begin_time => date + 7.days,
                                  :end_time   => date + 9.days) 
      # 3 days
      @holiday_three  = Factory(  :holiday, 
                                  :leave_length  => 'many',
                                  :state => 1, 
                                  :leave_type => 'etc', 
                                  :user => @user_two, 
                                  :begin_time => date + 14.days,
                                  :end_time   => date + 16.days ) 
      
      @holiday_four   = Factory(  :holiday, 
                                  :leave_length  => 'many',
                                  :state => 0, 
                                  :leave_type => 'etc', 
                                  :user => @user_two, 
                                  :begin_time => date + 32.days,
                                  :end_time   => date + 34.days ) 
    end

    it "calculated used leave days for all users" do
      # holiday_one and holiday_two belong to same user, the begin and end dates 
      # are the same for both holidays, therefore only two days get counted. 
      #
      # The other two days of leave come from holiday_four which belongs to user_two
      Holiday.get_taken_leave.should eql( 9.0 )
    end#it
    it "should calulate holidays taken by single user" do
      sum = 0
      @user_one.holidays.each {|h| sum += h.included_dates().length }
      sum.should == ( 6.0 )
    end
    it "calculates available leave for all users" do
    # this is handled by the user model.
    end


    end#desc

end#desc

describe "creating two holidays on one calendar day" do

  describe "using set theory to " do

    it "should not find a holiday in range when user has only one holiday" do
      user    = Factory( :user , :login => 'rsmithwhowho')
      holiday = Factory.build(  :holiday, 
                                :user => user,
                                :begin_time =>  DateTime.now,
                                :end_time   =>  DateTime.now + 2.days)
      holiday.in_range_of_existing.should eql( false )      
    end#it

    it "should error when a user has one holiday and then requests idenctical set of days for holiday" do
      user    = Factory( :user , :login => 'rsmithwhowho')
      holiday = Factory.build( :holiday, 
                          :leave_length => 'many',
                          :user => user,
                          :begin_time =>  DateTime.now,
                          :end_time   =>  DateTime.now + 2.days)

      holiday.in_range_of_existing.should eql( false )      
      holiday.save.should eql( true )

      another_holiday = Factory.build(  :holiday, 
                                        :leave_length => 'many',
                                        :user => user,
                                        :begin_time =>  DateTime.now,
                                        :end_time   =>  DateTime.now + 2.days)
      another_holiday.in_range_of_existing.should eql( true )      
    end#it

  end#des

  describe "new holidays should be inspected and reported if they include a date in users history" do
    before(:each) do
      @user = Factory( :user, :login => "whowhoha" )
    end#before

    it "should add an error when a new holiday is spanning previous holidays" do
      @holiday1 = Factory.build(  :holiday,  
                                  :leave_length => 'whole',
                                  :user => @user,
                                  :begin_time => MONDAY,
                                  :end_time   => WEDNESDAY)

      @holiday1.in_range_of_existing.should eql( false )
      @holiday1.save.should eql( true )

      @holiday2 = Factory.build(  :holiday,  
                                  :leave_length => 'whole',
                                  :user => @user,
                                  :begin_time => MONDAY,
                                  :end_time   => THURSDAY )              
      @holiday2.in_range_of_existing.should eql( true )
      @holiday2.save
      @holiday2.should_not be_valid
    end

    
  end#describe
  
  describe "creating a new holiday should only add unqique calendar days to a holdiay" do
    date = MONDAY
    before(:each) do
      @user = Factory( :user )
      @holiday1 = Factory(  :holiday, :user => @user, 
                            :begin_time => date,
                            :end_time   => date + 2.days)

      @holiday2 = Factory.build(  :holiday, :user => @user, 
                                  :begin_time => date ,
                                  :end_time   => date + 2.days)
      @holiday2.should_not be_valid     
    end#before

    it "should calculate only uniquie holiday days" do
      @holiday1.get_length.should eql( 3.0 )
    end

  end#describe
  
end#describe

describe "getting a list of dates that the user has holidays for" do

  before(:each) do
   dt = MONDAY
   @user = Factory( :user ) 
   @holiday = Factory(    :holiday, 
                          :leave_length => 'many',
                          :user => @user,
                          :begin_time => dt,
                          :end_time   => dt + 2.days )
  end#do
  
  it "should return a list of a range of days that span a holiday" do
    @holiday.included_dates().length.should eql( 3 )
  end
  
  it "should find a day that is in range of a holiday" do
    @arb_day = TUESDAY
    @holiday.included_dates.include?( @arb_day ).should eql( true )
    @arb_day = FRIDAY
    @holiday.included_dates.include?( @arb_day ).should eql( false )
  end

  it "should return the begin_date for half-day holidays" do
    @h = Factory(   :holiday, 
                    :leave_length => 'half',
                    :user => @user, 
                    :begin_time   =>  FRIDAY,
                    :end_time     =>  nil)
    @h.included_dates.include?( FRIDAY ).should eql( true )
    @h.included_dates.length.should eql( 1 )
  end
end#des

describe "pushing a holiday to gcal" do
  before(:each) do
    @user     = Factory( :user)
    @holiday  = Factory( :holiday, :user => @user )
  end#before

  it "should add a new push job to the queue" do
    Holiday.should_receive(:send_later).with( :update_calendar, @holiday )
    @holiday.approve( @user )
  end#it

end#desc

describe "removing weekends from holiday range" do
  before(:each)do
    friday  = DateTime.now.change(:year => 2009, :month => 5, :day => 8 )
    tuesday = DateTime.now.change(:year => 2009, :month => 5, :day => 12)

    @holiday = Factory( :holiday,
                        :leave_length =>  'many',
                        :begin_time =>  friday,
                        :end_time   =>  tuesday )
  end
  it "should remove saturday and sunday from a holiday's range" do
    @holiday.get_length.should == 3.0
  end
end

