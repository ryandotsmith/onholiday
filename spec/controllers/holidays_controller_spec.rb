=begin
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HolidaysController do

  def mock_holiday(stubs={})
    @mock_holiday ||= mock_model(Holiday, stubs)
  end
  
  describe "responding to GET index" do
    it "should expose all holidays as @holidays" do
      Holiday.should_receive(:find).with(:all).and_return([mock_holiday])
      get :index
      assigns[:holidays].should == [mock_holiday]
    end
  end

  describe "responding to GET show" do
    it "should expose the requested holiday as @holiday" do
      Holiday.should_receive(:find).with("37").and_return(mock_holiday)
      get :show, :id => "37"
      assigns[:holiday].should equal(mock_holiday)
    end    
  end

  describe "responding to GET new" do
  
    it "should expose a new holiday as @holiday" do
      Holiday.should_receive(:new).and_return(mock_holiday)
      get :new
      assigns[:holiday].should equal(mock_holiday)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested holiday as @holiday" do
      Holiday.should_receive(:find).with("37").and_return(mock_holiday)
      get :edit, :id => "37"
      assigns[:holiday].should equal(mock_holiday)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created holiday as @holiday" do
        Holiday.should_receive(:new).with({'these' => 'params'}).and_return(mock_holiday(:save => true))
        post :create, :holiday => {:these => 'params'}
        assigns(:holiday).should equal(mock_holiday)
      end

      it "should redirect to the created holiday" do
        Holiday.stub!(:new).and_return(mock_holiday(:save => true))
        post :create, :holiday => {}
        response.should redirect_to(holiday_url(mock_holiday))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved holiday as @holiday" do
        Holiday.stub!(:new).with({'these' => 'params'}).and_return(mock_holiday(:save => false))
        post :create, :holiday => {:these => 'params'}
        assigns(:holiday).should equal(mock_holiday)
      end

      it "should re-render the 'new' template" do
        Holiday.stub!(:new).and_return(mock_holiday(:save => false))
        post :create, :holiday => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested holiday" do
        Holiday.should_receive(:find).with("37").and_return(mock_holiday)
        mock_holiday.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :holiday => {:these => 'params'}
      end

      it "should expose the requested holiday as @holiday" do
        Holiday.stub!(:find).and_return(mock_holiday(:update_attributes => true))
        put :update, :id => "1"
        assigns(:holiday).should equal(mock_holiday)
      end

      it "should redirect to the holiday" do
        Holiday.stub!(:find).and_return(mock_holiday(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(holiday_url(mock_holiday))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested holiday" do
        Holiday.should_receive(:find).with("37").and_return(mock_holiday)
        mock_holiday.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :holiday => {:these => 'params'}
      end

      it "should expose the holiday as @holiday" do
        Holiday.stub!(:find).and_return(mock_holiday(:update_attributes => false))
        put :update, :id => "1"
        assigns(:holiday).should equal(mock_holiday)
      end

      it "should re-render the 'edit' template" do
        Holiday.stub!(:find).and_return(mock_holiday(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested holiday" do
      Holiday.should_receive(:find).with("37").and_return(mock_holiday)
      mock_holiday.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the holidays list" do
      Holiday.stub!(:find).and_return(mock_holiday(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(holidays_url)
    end

  end

end
=end