class Gift < ActiveRecord::Base
  
  def pledge_math
    pledges = Pledge.where("gift_id" => self.id)
    total = pledges.sum(:amount)
    remaining = '%.2f' % (self.cost - total)
    return total, remaining
  end

  def funded_trigger
    total, remaining = self.pledge_math
    if total == self.cost
      
      self.funded = true
      self.save
    end
    return self.funded
  end
end