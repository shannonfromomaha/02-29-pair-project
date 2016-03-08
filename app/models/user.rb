# users table columns:
# "name" (string)
# "email" (string)
# "password" (string)
class User < ActiveRecord::Base
  include Errors
  include Emails
  
  def pledged_gifts
    gifts = []
    Pledge.where("user_id" => self.id).each do |pledge|
      gifts << Gift.find_by_id(pledge.gift_id)
      return gifts
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