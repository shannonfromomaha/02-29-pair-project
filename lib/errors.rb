module Errors
  def get_errors
    # returns Array of errors from set_errors method 
    return @errors
  end
  
  def is_valid
    # method checks to see if form input is valid (i.e. no required fields are left blank)
    self.set_errors
    if @errors.length > 0
      return false
    else
      return true
    end
  end
end
