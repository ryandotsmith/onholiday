require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Verify user from CAS" do
  before(:each) do
    @cas_extra = {
      "cn"        => "Ryan Smith", 
      "memberOf"  => "CN=google_apps,OU=GS_KC,DC=gs-enterprises,DC=local",
      "mail"      => "rsmith@gsenterprises.com"
    }
    @cas_user = "rsmith"
  end
  
  it "should return true if the user is in the table" do
    @user = Factory( :user, :login => "rarbuckle")
    User.verify("rarbuckle",{}).should eql( true )
  end
  
  it "should create a new user if not already in Users table" do
    User.verify(@cas_user,@cas_extra).should eql('rsmith')
  end
  
  it "should add the name and mail attributes on creation of a new user" do
    User.verify(@cas_user,@cas_extra).should eql('rsmith')
    User.find_by_login('rsmith').email.should eql("rsmith@gsenterprises.com")
  end
  
  it "should not freak out if the extra attributes are missing" do
    User.verify(@cas_user,nil).should eql( false )
    User.verify(nil,nil).should eql( false )
  end
  
end

describe "Provide valuable statistics on holiday data" do
 
  before(:each) do
    date_time = MONDAY
    @user = Factory( :user )
    @h1   = Factory(  :holiday,
                      :leave_length  => 'many',
                      :state => 1 , 
                      :user => @user,
                      :begin_time => date_time,
                      :end_time   => date_time + 2.days)
    @h2   = Factory(  :holiday,
                      :leave_length => 'many',
                      :state => 1 , 
                      :user => @user,
                      :begin_time => date_time + 7.days,
                      :end_time   => date_time + 9.days)
    @h3   = Factory(  :holiday,
                      :leave_length => 'many',
                      :state => 1, 
                      :leave_type => 'vacation', 
                      :user => @user,
                      :begin_time => date_time + 14.days,
                      :end_time   => date_time + 16.days)
  end#do 

  it "should return a list of dates of days included in all of user's holidays" do
    # since the holidays created in the before block have unique calendars days,
    # and each holiday has 2 calendars days, the list of dates should containt 
    # 6 dates. 
    @user.get_list_of_dates.length.should eql( 9 )
    @user.get_list_of_dates.first.class.should eql( Date )
  end
  it "should only take into account unique calendar days" do
    # this should not be an issue. A holiday that is created will 
    # fail validation if the given holiday
    
  end

  it "should return the number of days taken on holiday" do

    ordered_dictionary = Dictionary.new
    ordered_dictionary[:etc] = 6.0
    ordered_dictionary[:personal] = 0
    ordered_dictionary[:vacation] = 3.0
    @user.holidays.length.should eql( 3 )
    @user.get_total_holiday_time.should eql( 9.0 )
    @user.get_taken_holiday_time.should == ordered_dictionary

  end
  
  it "should return a hash of holidays with the number of days the user has taken" do
    ordered_dictionary = Dictionary.new
    ordered_dictionary[:etc] = 4.0
    ordered_dictionary[:personal] = 10.0
    ordered_dictionary[:vacation] = 7.0
    @user.holidays.length.should eql( 3 )
    @user.get_total_holiday_time.should eql( 9.0 )
    @user.get_remaining_holiday_time.should == ordered_dictionary    
  end
  
  it "should return a hash of holidays with the number of days the user has left" do
    ordered_dictionary = Dictionary.new
    ordered_dictionary[:etc] = 4.0
    ordered_dictionary[:personal] = 10.0
    ordered_dictionary[:vacation] = 7.0
    @user.holidays.length.should eql( 3 )
    @user.get_total_holiday_time.should eql( 9.0 )
    @user.get_remaining_holiday_time.should == ordered_dictionary
  end
  
  it "should return max holiday time for ALL users" do
    @user.holidays << [@h1,@h2]
    User.get_total_holiday_time.should eql( 30 )
  end

end
