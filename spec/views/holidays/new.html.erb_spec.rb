require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/holidays/new.html.erb" do
  include HolidaysHelper
  
  before(:each) do
    assigns[:holiday] = stub_model(Holiday,
      :new_record? => true,
      :approved_by => "value for approved_by"
    )
  end

  it "should render new form" do
    render "/holidays/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", holidays_path) do
      with_tag("input#holiday_approved_by[name=?]", "holiday[approved_by]")
    end
  end
end


