MyApp.get "/gifts" do
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
  erb :"gifts/show"
end

MyApp.get "/gifts/:id/edit" do
  erb :"gifts/edit"
end

MyApp.post "/gifts/:id/update" do
  
end

MyApp.post "/gifts/:id/delete" do
  
end