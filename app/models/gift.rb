class Gift < ActiveRecord::Base
  # pledge_math calculates pledges on this gift
  # must set two variables, ex: x,y = gift.pledge_math
  #
  # Returns Array of two values, total pledges and remaining cost of gift.
  def pledge_math
    pledges = Pledge.where("gift_id" => self.id)
    total = pledges.sum(:amount)
    remaining = '%.2f' % (self.cost - total)
    return total, remaining
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
end