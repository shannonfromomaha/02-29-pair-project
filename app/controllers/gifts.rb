MyApp.before "/gifts*" do
  @user = User.find_by_id(session["user_id"]) 
  if @user == nil
    redirect "/logins/new"
  end
end

MyApp.get "/gifts" do
  @gifts = Gift.all
  erb :"gifts/index"
end

MyApp.get "/gifts/new" do
  erb :"gifts/new"
end

MyApp.post "/gifts/create" do
  @gift = Gift.new
  @gift.title = params["title"]
  @gift.recipient = params["recipient"]
  @gift.description = params["description"]
  @gift.link = params["link"]
  @gift.cost = params["cost"]
  
#once logins created, logged in user = @gift.user_id
  @gift.funded = false
  @gift.save
  redirect "/gifts/#{@gift.id}"
end

MyApp.get "/gifts/:id" do
  @gift = Gift.find_by_id(params[:id]) 
  @pledges = Pledge.collect_pledges(@gift.id)
  binding.pry
  erb :"gifts/show"
end

MyApp.get "/gifts/:id/edit" do
  @gift = Gift.find_by_id(params[:id])
  erb :"gifts/edit"
end

MyApp.post "/gifts/:id/update" do
  @gift = Gift.find_by_id(params[:id])
  @gift.title = params["title"]
  @gift.recipient = params["recipient"]
  @gift.description = params["description"]
  @gift.link = params["link"]
  @gift.cost = params["cost"]
  @gift.save
  redirect  "/gifts/#{@gift.id}"
end

MyApp.post "/gifts/:id/delete" do
  @gift = Gift.find_by_id(params[:id])
  @gift.delete
  redirect "/"
end