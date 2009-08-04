require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "creating an event" do
  before(:each) do
    @holiday = OpenStruct.new
    @holiday.should_receive(:user).any_number_of_times.and_return( OpenStruct.new )
    @holiday.should_receive(:id).any_number_of_times.and_return( 1 )
    @holiday.begin_time   = DateTime.now
    @holiday.end_time     = DateTime.now + 3.days
    @holiday.user.name    = "rsmith"
    @holiday.description  = "nothing to see"
    
  end
  it "make XML for an event" do
    event = Gcal::Event.new( @holiday )
    # TODO: these strings are very similar, why will they not pass a test?
  end

end

