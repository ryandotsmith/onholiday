class Postoffice < ActionMailer::Base
  
  def new_request( request )
    admins      = Array.new
    User.get_admins.each do |admin|
      admins << admin.email
    end
    @subject    = 'time off request'
    @recipients = admins
    @from       = 'onHoliday@gsenterprises.com'
    @sent_on    = Time.now
    @body["request"]  = request
  end#end method

end#end class
