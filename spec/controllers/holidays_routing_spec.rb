=begin
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HolidaysController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "holidays", :action => "index").should == "/holidays"
    end
  
    it "should map #new" do
      route_for(:controller => "holidays", :action => "new").should == "/holidays/new"
    end
  
    it "should map #show" do
      route_for(:controller => "holidays", :action => "show", :id => 1).should == "/holidays/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "holidays", :action => "edit", :id => 1).should == "/holidays/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "holidays", :action => "update", :id => 1).should == "/holidays/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "holidays", :action => "destroy", :id => 1).should == "/holidays/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/holidays").should == {:controller => "holidays", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/holidays/new").should == {:controller => "holidays", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/holidays").should == {:controller => "holidays", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/holidays/1").should == {:controller => "holidays", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/holidays/1/edit").should == {:controller => "holidays", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/holidays/1").should == {:controller => "holidays", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/holidays/1").should == {:controller => "holidays", :action => "destroy", :id => "1"}
    end
  end
end
=end