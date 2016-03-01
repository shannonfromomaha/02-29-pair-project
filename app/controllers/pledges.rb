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
  @gift = Gift.find_by_id(params["gift"])
  @pledge = Pledge.new
  @pledge.amount = params["amount"]
  @pledge.user_id = session["user_id"]
  @pledge.gift_id = params["gift"]
  @pledge.save

  redirect "/gifts/#{@gift.id}"
end

