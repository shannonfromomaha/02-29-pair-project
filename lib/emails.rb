module Email
  # this module WILL BE used in Pledge and User controllers
  @creator = User.find_by_id(@gift.user_id)
      Pony.mail(:to => @creator.email, :from => 'shannonfromomaha@gmail.com', :subject => 'your thing got funded!', :body => 'yay.')

  @participants = Pledge.collect_pledges(@gift.id)

      @participants.each do |participant|
        Pony.mail(:to => participant[1], :from => 'shannonfromomaha@gmail.c', :subject => 'gift got bought!', :body => 'yay. you did it!')

end
