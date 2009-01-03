require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/holidays/edit.html.erb" do
  include HolidaysHelper
  
  before(:each) do
    assigns[:holiday] = @holiday = stub_model(Holiday,
      :new_record? => false,
      :approved_by => "value for approved_by"
    )
  end

  it "should render edit form" do
    render "/holidays/edit.html.erb"
    
    response.should have_tag("form[action=#{holiday_path(@holiday)}][method=post]") do
      with_tag('input#holiday_approved_by[name=?]', "holiday[approved_by]")
    end
  end
end


