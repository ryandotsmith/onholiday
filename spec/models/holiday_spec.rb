require 'facets/dictionary'

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../factories/holiday_factory')
require File.expand_path(File.dirname(__FILE__) + '/../factories/user_factory')

### Factory :holiday => defaults[ end_time - begin_time == 2.days]

describe "creating a holiday" do
  before(:each) do
    @user    = Factory( :user )
    @holiday = Factory.build( :holiday, :user => @user, 
                                  :begin_time => DateTime.now,
                                  :end_time => nil)
    @holiday.update_hook('whole')
  end#before
  it "should not care if end time is nil" do
    @holiday.end_time.should_not eql( nil )
    @holiday.end_time.should eql( @holiday.begin_time.end_of_day )
    @holiday.get_length.should eql( 1.0 )
  end

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
  
  it "should return an integer which represents the number of whole days" do
    dt = DateTime.now
    @holiday = Factory.build( 
                        :holiday, 
                        :begin_time => dt,
                        :end_time   => dt + 1.days )
    @holiday.update_hook( 'whole' )
    @holiday.get_length.should eql( 2.0 )
  end# end it 

  it "should correctly calculate 1 day of leave " do
    bt  = DateTime.now
    @holiday = Factory.build( 
                        :holiday,
                        :begin_time =>  bt,
                        :end_time   =>  bt  )
    @holiday.update_hook( 'whole' )
    @holiday.get_length.should eql( 1.0 )
    
  end
  it "should correctly calculate 2 days of leave " do
    bt  = DateTime.now.beginning_of_day
    @holiday = Factory.build( 
                        :holiday,
                        :begin_time =>  bt,
                        :end_time   =>  bt + 1.days )  
    @holiday.update_hook( 'whole' )
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
    @holiday = Factory.build( 
                              :holiday, 
                              :begin_time => DateTime.now,
                              :end_time   => DateTime.now )
    # have to override the before_save method to make a half day save
    @holiday.update_hook('half')
    @holiday.get_length.should eql( 0.5 )
    
  end

  it "should add 24 hours to the current DateTime submitted" do
    @holiday = Factory.build( 
                        :holiday, 
                        :begin_time => DateTime.now,
                        :end_time   => DateTime.now )
    @holiday.update_hook('whole')
    @holiday.get_length.should eql( 1.0 )
    
  end
end #end describe

describe "should return specific data sets" do

    describe "get holidays statistics for entire universe" do
    before(:each) do      
      date = DateTime.now
      @user_one       = Factory( :user , :login =>  "jbillings")
      @user_two       = Factory( :user , :login =>  "jhoover")

      @holiday_one    = Factory.build( :holiday, :state => 1, :leave_type => 'etc', :user => @user_one,
                                                  :begin_time => date,
                                                  :end_time   => date + 2.days) 
      @holiday_one.update_hook('whole')      
      @holiday_one.save!

      @holiday_two    = Factory.build( :holiday, :state => 1, :leave_type => 'etc', :user => @user_one, 
                                                  :begin_time => date + 14.days,
                                                  :end_time   => date + 16.days) 
      @holiday_two.update_hook('whole')      
      @holiday_two.save!
      
      @holiday_three  = Factory.build( :holiday, :state => 1, :leave_type => 'etc', :user => @user_two, 
                                                  :begin_time => date + 18.days,
                                                  :end_time   => date + 20.days ) 
      @holiday_three.update_hook('whole')      
      @holiday_three.save!
      
      @holiday_four   = Factory.build( :holiday, :state => 0, :leave_type => 'etc', :user => @user_two, 
                                                  :begin_time => date + 32.days,
                                                  :end_time   => date + 34.days ) 
      @holiday_four.update_hook('whole')      
      @holiday_four.save!

    end

    it "calculated used leave days for all users" do
      # holiday_one and holiday_two belong to same user, the begin and end dates 
      # are the same for both holidays, therefore only two days get counted. 
      #
      # The other two days of leave come from holiday_four which belongs to user_two
      Holiday.get_taken_leave.should eql( 9.0 )
    end#it

    it "calculates available leave for all users" do
    # this is handled by the user model.
    end

    it "returns the ratio of taken / available leave for all users" 

    end#desc

end#desc

describe "creating two holidays on one calendar day" do

  describe "using set theory to " do

    it "should not find a holiday in range when user has only one holiday" do
      @user    = Factory( :user , :login => 'rsmithwhowho')
      @holiday = Factory.build( :holiday, 
                                :user => @user,
                                :begin_time =>  DateTime.now,
                                :end_time   =>  DateTime.now + 2.days)
      @holiday.in_range_of_existing.should eql( false )      
    end#it

    it "should error when a user has one holiday and then requests idenctical set of days for holiday" do
      @user    = Factory( :user , :login => 'rsmithwhowho')
      @holiday = Factory.build( :holiday, 
                                :user => @user,
                                :begin_time =>  DateTime.now,
                                :end_time   =>  DateTime.now + 2.days)

      @holiday.in_range_of_existing.should eql( false )      
      @holiday.update_hook('whole')
      @holiday.save

      @holiday = Factory.build( :holiday, 
                                :user => @user,
                                :begin_time =>  DateTime.now,
                                :end_time   =>  DateTime.now + 2.days)
      @holiday.in_range_of_existing.should eql( true )      
    end#it

  end#des

  describe "new holidays should be inspected and reported if they include a date in users history" do
    before(:each) do
      @user = Factory( :user, :login => "whowhoha" )
    end#before

    it "should add an error when a new holiday is spanning previous holidays" do
      @holiday1 = Factory.build( :holiday,  :user => @user,
                                  :begin_time => DateTime.now,
                                  :end_time   => DateTime.now + 2.days)
      @holiday1.update_hook('whole')
      @holiday1.in_range_of_existing.should eql( false )
      @holiday1.save.should eql( true )

      @holiday2 = Factory.build( :holiday,  :user => @user,
                                  :begin_time => DateTime.now,
                                  :end_time   => DateTime.now + 3.days)              
      @holiday2.update_hook('whole')
      @holiday2.in_range_of_existing.should eql( true )
      @holiday2.save
      @holiday2.should_not be_valid
    end

    
  end#describe
  
  describe "creating a new holiday should only add unqique calendar days to a holdiay" do
    date = DateTime.now
    before(:each) do
      @user = Factory( :user )
      @holiday1 = Factory.build( :holiday, :user => @user, 
                            :begin_time => date,
                            :end_time   => date + 2.days)
      @holiday1.update_hook('whole')
      @holiday1.save

      @holiday2 = Factory.build( :holiday, :user => @user, 
                            :begin_time => date ,
                            :end_time   => date + 2.days)
      @holiday2.update_hook('whole')
      @holiday2.save.should eql( false )
     
    end#before

    it "should calculate only uniquie holiday days" do
      @holiday1.get_length.should eql( 3.0 )
    end

  end#describe
  
end#describe

describe "getting a list of dates that the user has holidays for" do

  before(:each) do
   @user = Factory( :user ) 
   @holiday = Factory.build( :holiday, :user => @user,
                                 :begin_time => DateTime.now.beginning_of_day,
                                 :end_time   => DateTime.now.beginning_of_day + 4.days )
  end#do
  
  it "should return a list of a range of days that span a holiday" do
    @holiday.print_days_in_between().length.should eql( 4 )
  end
  
  it "should find a day that is in range of a holiday" do
    @arb_day = DateTime.now + 2.days
    @arb_day = @arb_day.to_date
    @holiday.print_days_in_between.include?( @arb_day ).should eql( true )
    @arb_day += 3.days
    @holiday.print_days_in_between.include?( @arb_day ).should eql( false )
  end
end#des







