class Postoffice < ActionMailer::Base
  
  def new_request( request )
    admins      = Array.new
    User.get_admins.each do |admin|
      if admin.email.respond_to?(:length)
        if admin.email.length > 0
          admins << admin.email
        end#if
      end#if
    end#do

    @subject    = 'time off request'
    @recipients = admins
    @from       = 'onHoliday@gsenterprises.com'
    @sent_on    = Time.now
    @body["request"]  = request
  end#end method

  def new_request_to( user )
    @subject    =   '[ onholiday ] request submitted '
    @recipients =   user.email.to_s unless user.email.nil?
    @from       =   'onHoliday@gsenterprises.com'
    @sent_on    =   Time.now
  end
  
  def request_change( request, status )
    @subject    =   '[ onholiday ] request updated'
    @recipients =   user.email.to_s unless user.email.nil?
    @from       =   'onHoliday@gsenterprises.com'
    @sent_on    =   Time.now
  end
end#end class
