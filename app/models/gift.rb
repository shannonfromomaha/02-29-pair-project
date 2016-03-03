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

      #to gift creator
      @creator = User.find_by_id(self.user_id)
      Pony.mail(:to => @creator.email, :from => 'shannonfromomaha@gmail.com', :subject => 'your thing got funded!', :body => 'yay.')
     
      #to pledge participants
      @participants = Pledge.collect_pledges(self.id)
        
        @participants.each do |participant|
          Pony.mail(:to => participant[1], :from => 'shannonfromomaha@gmail.com', :subject => 'gift got bought!', :body => 'yay. you did it!')
        end

    else
    end
  end
end