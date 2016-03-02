class Gift < ActiveRecord::Base
  
  def pledge_math
    pledges = Pledge.where("gift_id" => self.id)
    total = pledges.sum(:amount)
    remaining = (self.cost - total).round(2)
    return total, remaining
  end

  def activate_boolean
  end
end