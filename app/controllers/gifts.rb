# limits access to logged in users
MyApp.before "/gifts*" do
  @user = User.find_by_id(session["user_id"])
  if @user == nil 
    redirect "/logins/new"
  end
end

# list of all gifts
MyApp.get "/gifts" do
  @gifts = Gift.all
  erb :"gifts/index"
end

# shows form to create new gift
MyApp.get "/gifts/new" do
  @errors = session["errors"]
  session["errors"] = nil
  erb :"gifts/new"
end

# processes form to create new gift
MyApp.post "/gifts/create" do
  @gift = Gift.new
  @gift.title = params["title"]
  @gift.recipient = params["recipient"]
  @gift.description = params["description"]
  @gift.link = params["link"]
  @gift.cost = (params["cost"].to_f.round(2))
  @gift.user_id = session["user_id"]
  @gift.funded = false
  if @gift.is_valid == true
    @gift.cost = @gift.cost * 100
    @gift.save
    redirect "/gifts/#{@gift.id}"
  else
    session["errors"] = @gift.get_errors
    redirect "/gifts/new"
  end
end

# unique page for individual gift (includes pledge form)
MyApp.get "/gifts/:id" do
  @gift = Gift.find_by_id(params[:id])
  @pledges = Pledge.collect_pledges(@gift.id)
  @total, @remaining = @gift.pledge_math
  @over_pledged = session["over_pledged"]
  session["over_pledged"] = false
  erb :"gifts/show"
end

# shows form for editing gift
MyApp.get "/gifts/:id/edit" do
  @gift = Gift.find_by_id(params[:id])
  erb :"gifts/edit"
end

# processes form for editing gift
MyApp.post "/gifts/:id/update" do
  @gift = Gift.find_by_id(params[:id])
  @gift.title = params["title"]
  @gift.recipient = params["recipient"]
  @gift.description = params["description"]
  @gift.link = params["link"]
  @gift.cost = params["cost"]
  @gift.save
  redirect "/gifts/#{@gift.id}"
end

# processes delete gift form
MyApp.post "/gifts/:id/delete" do
  @gift = Gift.find_by_id(params[:id])
  @gift.delete
  redirect "/"
end