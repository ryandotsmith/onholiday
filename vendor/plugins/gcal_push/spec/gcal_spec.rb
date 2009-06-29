require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "loading some default options with an acts_as method" do
  it "should load a default calendar" do
    Holiday.pushes_to_gcal()
    Holiday.options.should == {}
    Holiday.pushes_to_gcal({ :begin_time => :begin_time, :end_time => :end_time, :calendar => "whowho"  })
    Holiday.options.should == { :begin_time => :begin_time, :end_time => :end_time, :calendar => "whowho"  }
  end
end