class Pledge < ActiveRecord::Base
# a class method to find pledges
#
# "gift_id" = the id of the gift we're looking for
#
# Returns a hash of user objects and their pledges to this gift
  def self.collect_pledges(gift_id)
    x = Pledge.where("gift_id" => gift_id)
    pledges = []
    x.each do |pledge|
      user = User.find_by_id(pledge.user_id)
      y = [user.name, user.email, pledge.amount]
      pledges << y
    end
    return pledges
  end

end