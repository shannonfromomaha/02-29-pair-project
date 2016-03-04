class User < ActiveRecord::Base
  def pledged_gifts
    x = Pledge.where("user_id" => self.id)
    gifts = []
    x.each do |x|
      gifts << Gift.find_by_id(x.gift_id)
    end
    return gifts
  end
  def get_errors
    return @errors
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
  def is_valid
    self.set_errors
    if @errors.length > 0
      return false
    else
      return true
    end
  end
end