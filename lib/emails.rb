module Email
  # this module WILL BE used in Pledge and User controllers
  #
  #here's the email we send when a new user is created
  def new_user_email(user_email)
    Pony.mail(:to => user_email, :from => 'admin@kittypool.com', :subject => 'hey! new user!', :body => 'yay.')
  end
  #
  #here's the email we send to gift creators when their gifts are funded
  def funded_email_creator(user_email)
    #fix this
    @creator = User.find_by_id(@gift.user_id)
    Pony.mail(:to => @creator.email, :from => 'shannonfromomaha@gmail.com', :subject => 'your thing got funded!', :body => 'yay.')
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
