require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/holidays/index.html.erb" do
  include HolidaysHelper
  
  before(:each) do
    assigns[:holidays] = [
      stub_model(Holiday,
        :approved_by => "value for approved_by"
      ),
      stub_model(Holiday,
        :approved_by => "value for approved_by"
      )
    ]
  end

  it "should render list of holidays" do
    render "/holidays/index.html.erb"
    response.should have_tag("tr>td", "value for approved_by", 2)
  end
end

