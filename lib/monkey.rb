class Float
  ####################
  def approx other, epsilon=Float::EPSILON
    return( other - self ).abs <= epsilon
  end#approx 
end

class Date
  ####################
  #working_day?
  def working_day?
    self.wday != 6 and self.wday != 0
  end#working_day?
end