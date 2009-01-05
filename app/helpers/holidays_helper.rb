module HolidaysHelper

  ####################
  #get_state() should get
  #=> a holiday object 
  # and should return
  #=>
  def get_state( holiday )
    case holiday.state
    when -1
      return "<a style='color:red'>denied</a>"
    when 0
      return "<a style='color:yellow'>pending</a>"
    when 1
      return "<a style='color:green'>approved</a>"
    end#end case
  end#end get_state()
  
end
