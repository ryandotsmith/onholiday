require 'casclient'
require 'casclient/frameworks/rails/filter'

class HolidaysController < ApplicationController


######################################################
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :login
  before_filter :load_user, :only => [:new,:create]
  before_filter :current_user
  before_filter :authorized, :only => [:index]
######################################################  

  def index
    @holidays = Holiday.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @holidays }
    end
  end

  def show
    @holiday = Holiday.find( params[:id] )
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @holiday }
    end
  end

  def new
    @holiday = @user.holidays.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @holiday }
    end
  end

  def edit
    @holiday = Holiday.find(params[:id])
  end

  def create
    @holiday = @user.holidays.build( params[:holiday] )
    respond_to do |format|
      @holiday.update_hook( params[:length_opt] )
      if @holiday.save()
        Postoffice.deliver_new_request( @holiday )
        
        format.html { redirect_to user_path(@user) }
        format.xml  { render :xml => @holiday, :status => :created, :location => @holiday }
      else
        format.html { render( :action => "new" ) {|page| page.alert('booha')} }
        format.xml  { render :xml => @holiday.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @holiday = Holiday.find(params[:id])
    # need to factor these into a method in the model !! 
      @holiday.approve( current_user ) if params[:approved] == "true"
      @holiday.deny( current_user ) if params[:deny] == "true"
    ### 
    respond_to do |format|
      if @holiday.update_attributes(params[:holiday])
        format.html { redirect_to(@holiday) }
        format.xml  { head :ok }
        format.js   
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @holiday.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @holiday = Holiday.find(params[:id])
    @holiday.destroy
    respond_to do |format|
      format.html { redirect_to(holidays_url) }
      format.xml  { head :ok }
    end
  end
protected
  ####################
  #load_user should get
  #=>
  # and should return
  #=>
  def load_user
    @user = User.find(params[:user_id])
  end
end #end class
