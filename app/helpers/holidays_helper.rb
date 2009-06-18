module HolidaysHelper

  def display_search_params( params )
    "#{params[:search]}'s holidays. #{link_to 'all users', holidays_path }" if
      params[:search]
  end

  def in_words( state )
    case state
    when -1
      return "denied"
    when 0
      return "pending"
    when 1
      return "approved"
    end#end case
  end

  def get_state( holiday )
    case holiday.state
    when -1
      return "<a style='color:red'>denied</a>"
    when 0
      return "<a style='color:orange'>pending</a>"
    when 1
      return "<a style='color:green'>approved</a>"
    end#end case
  end#end get_state()
  
  def length_of_holiday_in_words( holiday)
    length = holiday.get_length
    case length
    when 0.0
      "zero days"
    when 0.5
      "half day"
    when 1.0
      "1 day"
    else
      "#{ length.to_i } days"
    end
  end
end
