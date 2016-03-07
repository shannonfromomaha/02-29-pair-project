module Errors
  def get_errors
    return @errors
  end
  def is_valid
    self.set_errors
    if @errors.length > 0
      return false
    else
      return true
    end
  end
end
