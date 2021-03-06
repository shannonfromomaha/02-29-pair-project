# limits access to logged in users
MyApp.before "/pledges*" do
  @user = User.find_by_id(session["user_id"])
  if @user == nil
    redirect "/logins/new"
  end
end

# shows admin all pledges EVER
#
# administrative access not yet created
MyApp.get "/pledges" do
  session["current_page"] = "/gifts"
  @pledges = Pledge.all
  erb :"pledges/index"
end

# processes form for creating new pledge
MyApp.post "/pledges/create" do
  @gift = Gift.find_by_id(params[:gift])
  @pledge = Pledge.new
  @pledge.amount = (params[:amount]).to_f.round(2)
  @pledge.user_id = session[:user_id]
  @pledge.gift_id = params[:gift]
  @total, @remaining = @gift.pledge_math
  # pledges that exceed the remaining amount are not accepted
  if @pledge.amount > @remaining.to_f
    session["over_pledged"] = true
    redirect "/gifts/#{@gift.id}"
  else
    @pledge.save
    # things happen if this new pledge funds the gift
    if @gift.funded_trigger == true
      # email to gift creator
      User.find_by_id(@gift.user_id).funded_email_to_creator
      # email to pledge participants
      @gift.funded_email_to_pledges
    end
    redirect "/gifts/#{@gift.id}"
  end
end