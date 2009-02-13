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

end#end class
