MyApp.before "/pledges*" do
  @user = User.find_by_id(session["user_id"]) 
  if @user == nil
    redirect "/logins/new"
  end
end

MyApp.get "/pledges" do
  erb :"pledges/index"
end

MyApp.get "/pledges/new" do
  erb :"pledges/new"
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

MyApp.get "/pledges/:id" do
  erb :"pledges/show"
end

MyApp.get "/pledges/:id/edit" do
  erb :"pledges/edit"
end

MyApp.post "/pledges/:id/update" do
  
end

MyApp.post "/pledges/:id/delete" do
  
end