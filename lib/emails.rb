module Emails
  # this module WILL BE used in User model
  #
  #here's the email we send when a new user is created
  #new_user_email is called on USER objects
  def new_user_email
    Pony.mail(:to => self.email, :from => 'admin@kittypool.com', :subject => 'hey! new user!', :body => 'yay.')
  end
  #
  #here's the email we send to gift creators when their gifts are funded
  #funded_email_to_creator is called on USER objects
  def funded_email_to_creator
    Pony.mail(:to => self.email, :from => 'admin@kittypool.com', :subject => 'the gift you created is now funded!', :body => 'yay! some people owe you money.')
  end
  
  #here's the email we send to pledgers when a gift is fully funded
  #funded_email_to_pledges is called on GIFT class
  def funded_email_to_pledges
    Pledge.where("gift_id" => self.id).each do |pledge|
      user = User.find_by_id(pledge.user_id)
      Pony.mail(:to => user.email, :from => 'admin@kittypool.com', :subject => 'gift got bought!', :body => 'yay. you did it! now you owe money.')
    end
  end

end
