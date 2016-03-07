# gifts table columns:
# "user_id" (integer) -- who created gift
# "title" (string)
# "description" (text)
# "link" (string) -- link to item in online store
# "recipient" (string)
# "cost" (float)
# "funded" (boolean) whether total pledges == cost
class Gift < ActiveRecord::Base
  include Errors  
  # pledge_math calculates pledges on this gift
  # must set two variables, ex: x,y = gift.pledge_math
  #
  # Returns Array of two values, total pledges and remaining cost of gift.
  def pledge_math
    pledges = Pledge.where("gift_id" => self.id)
    total = pledges.sum(:amount)
    remaining = self.cost - total
    return total.to_f, remaining.to_f
  end

  # funded_trigger calculates if contributions = cost of gift
  #
  # Returns Boolean of funded status
  def funded_trigger
    total, remaining = self.pledge_math
    if total == self.cost
      self.funded = true
      self.save
    end
    return self.funded
  end
  def get_errors
    return @errors
  end
  def set_errors
    @errors = []
    if self.title == ""
      @errors << "Title cannot be blank"
    end
    if self.recipient == ""
      @errors << "Recipient cannot be blank"
    end
    if self.cost == "" || self.cost == 0
      @errors << "Cost must be formatted as <i>ex: 5.55</i>"
    end
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