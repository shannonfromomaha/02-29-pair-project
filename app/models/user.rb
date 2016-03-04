class User < ActiveRecord::Base
  def pledged_gifts
    x = Pledge.where("user_id" => self.id)
    gifts = []
    x.each do |x|
      gifts << Gift.find_by_id(x.gift_id)
    end
    return gifts
  end
end