module RevertData
  class Action
    ####################
    #update_time
    def self.update_time
      Holiday.find(:all).each do |holiday|
        holiday.adjust_time!('half') if holiday.half_days.length > 0
        holiday.adjust_time!('whole') if holiday.whole_days.length == 1
        holiday.adjust_time!('many') if holiday.whole_days.length > 1
        holiday.save!
      end
    end#update_time
  end
end