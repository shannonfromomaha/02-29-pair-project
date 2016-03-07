# users table columns:
# "name" (string)
# "email" (string)
# "password" (string)
class User < ActiveRecord::Base
  include Errors
  def pledged_gifts
    x = Pledge.where("user_id" => self.id)
    if x == nil
      return ""
    else
      gifts = []
      x.each do |x|
        gifts << Gift.find_by_id(x.gift_id)
        return gifts
      end
    end
  end
  def set_errors
    @errors = []
    if self.name == ""
      @errors << "Name cannot be blank"
    end
    if self.email == ""
      @errors << "Email cannot be blank"
    end
    if self.password == ""
      @errors << "Password cannot be blank"
    end
  end
end