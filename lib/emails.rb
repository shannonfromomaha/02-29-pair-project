module Emails
  # this module WILL BE used in User model
  #
  #here's the email we send when a new user is created
  def new_user_email
    Pony.mail(:to => self.email, :from => 'admin@kittypool.com', :subject => 'hey! new user!', :body => 'yay.')
  end
  #
  #here's the email we send to gift creators when their gifts are funded
  def funded_email_creator
    Pony.mail(:to => @self.email, :from => 'admin@kittypool.com', :subject => 'the gift you created is now funded!', :body => 'yay! some people owe you money.')
  end
  #
  #here's the email we send to pledgers when a gift is fully funded
  def funded_email_pledges(putsomethinghere)
    @participants = Pledge.collect_pledges(@gift.id)
    @participants.each do |participant|
        Pony.mail(:to => participant[1], :from => 'shannonfromomaha@gmail.c', :subject => 'gift got bought!', :body => 'yay. you did it!')
    end
  end
#
end
