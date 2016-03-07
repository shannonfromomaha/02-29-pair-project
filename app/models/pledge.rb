# pledges table columns:
# "user_id" (integer)
# "gift_id" (integer)
# "amount" (float)
class Pledge < ActiveRecord::Base
  # a Class method to find all pledges for a gift
  #
  # "gift_id" = the id of the gift we're looking for
  #
  # Returns Array of Arrays with user/pledge information
  def self.collect_pledges(gift_id)
    gift_pledges = Pledge.where("gift_id" => gift_id)
    pledges = []
    gift_pledges.each do |pledge|
      user = User.find_by_id(pledge.user_id)
      gather_pledge_info = [user.name, user.email, pledge.amount]
      pledges << gather_pledge_info
    end
    return pledges
  end
end