require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require File.expand_path(File.dirname(__FILE__) + '/../factories/holiday_factory')
require File.expand_path(File.dirname(__FILE__) + '/../factories/user_factory')

describe User do
  before(:each) do
    @valid_attributes = {
      :login => "value for login"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end

describe "Verify user from CAS" do
  fixtures :users
  before(:each) do
    @cas_extra = {
      "cn"        => "Ryan Smith", 
      "memberOf"  => "CN=google_apps,OU=GS_KC,DC=gs-enterprises,DC=local",
      "mail"      => "rsmith@gsenterprises.com"
    }
    @cas_user = "rsmith"
  end
  
  it "should return true if the user is in the table" do
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
    @user = Factory( :user )
    @h1   = Factory( :holiday,:state => 1 )
    @h2   = Factory( :holiday,:state => 1 )
    @h3   = Factory( :holiday,:state => 1, :leave_type => 'vacation')
  end
  
  it "should return the number of days taken on holiday" do
    ordered_dictionary = Dictionary.new
    ordered_dictionary[:etc] = 4
    ordered_dictionary[:personal] = 0
    ordered_dictionary[:vacation] = 2
    @user.holidays << [@h1,@h2,@h3]
    @user.holidays.length.should eql( 3 )
    @user.get_total_holiday_time.should eql( 6 )
    @user.get_taken_holiday_time.should == ordered_dictionary
  end
  
  it "should return a hash of holidays with the number of days the user has taken" do
    ordered_dictionary = Dictionary.new
    ordered_dictionary[:etc] = 1
    ordered_dictionary[:personal] = 5
    ordered_dictionary[:vacation] = 5
    @user.holidays << [@h1,@h2]
    @user.holidays.length.should eql( 2 )
    @user.get_total_holiday_time.should eql( 4 )
    @user.get_remaining_holiday_time.should == ordered_dictionary    
  end
  
  it "should return a hash of holidays with the number of days the user has left" do
    ordered_dictionary = Dictionary.new
    ordered_dictionary[:etc] = 1
    ordered_dictionary[:personal] = 5
    ordered_dictionary[:vacation] = 5
    @user.holidays << [@h1,@h2]
    @user.holidays.length.should eql( 2 )
    @user.get_total_holiday_time.should eql( 4 )
    @user.get_remaining_holiday_time.should == ordered_dictionary
  end
end