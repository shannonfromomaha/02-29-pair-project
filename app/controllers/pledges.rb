MyApp.before "/pledges*" do
  @user = User.find_by_id(session["user_id"]) 
  if @user == nil
    redirect "/logins/new"
  end
end

MyApp.get "/pledges" do
  @pledges = Pledge.all
  erb :"pledges/index"
end

MyApp.post "/pledges/create" do
  @gift = Gift.find_by_id(params[:gift])
  @pledge = Pledge.new
  @pledge.amount = (params[:amount]).to_f.round(2)
  @pledge.user_id = session[:user_id]
  @pledge.gift_id = params[:gift]
  @total, @remaining = @gift.pledge_math
  
  if @pledge.amount > @remaining.to_f
    session["over_pledged"] = true
    redirect "/gifts/#{@gift.id}"
  
  else
    @pledge.save
    if @gift.funded_trigger == true
      #to gift creator
      @creator = User.find_by_id(@gift.user_id)
      Pony.mail(:to => @creator.email, :from => 'shannonfromomaha@gmail.com', :subject => 'your thing got funded!', :body => 'yay.')
     
      #to pledge participants
      @participants = Pledge.collect_pledges(@gift.id)

      @participants.each do |participant|
        Pony.mail(:to => participant[1], :from => 'shannonfromomaha@gmail.c', :subject => 'gift got bought!', :body => 'yay. you did it!')
      end
    
    end
    redirect "/gifts/#{@gift.id}"
  end
end

