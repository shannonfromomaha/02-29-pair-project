MyApp.get "/users" do
  @user = User.find_by_id(session["user_id"])
  if @user == nil
    redirect "/logins/new"
  else
    @users = User.all 
    erb :"users/index"
  end
end

MyApp.get "/users/new" do
  erb :"users/new"
end

MyApp.post "/users/create" do
  @user = User.new
  @user.name = params["name"]
  @user.email = params["email"]
  @user.password = params["password"]
  @user.save
  Pony.mail(:to => @user.email, :from => 'shannonfromomaha@gmail.com', :subject => 'new user!', :body => 'yay.')

  redirect "/users/#{@user.id}"
end

MyApp.get "/users/:id" do
  @user = User.find_by_id(session["user_id"])
  if @user == nil
    redirect "/logins/new"
  else
    @user = User.find_by_id(params[:id])
    erb :"users/show"
  end
end

MyApp.get "/users/:id/edit" do
  @user = User.find_by_id(session["user_id"])
  if @user == nil
    redirect "/logins/new"
  else
    @user = User.find_by_id(params[:id]) 
    erb :"users/edit"
  end
end

MyApp.post "/users/:id/update" do
  @user = User.find_by_id(session["user_id"])
  if @user == nil
    redirect "/logins/new"
  else
    @user = User.find_by_id(params[:id])
    @user.name = params["name"]
    @user.email = params["email"]
    @user.password = params["password"]
    @user.save
    redirect "/users/#{@user.id}"
  end
end

MyApp.post "/users/:id/delete" do
  @user = User.find_by_id(session["user_id"])
  if @user == nil
    redirect "/logins/new"
  else
    @user = User.find_by_id(params[:id]) 
    @user.delete
    redirect "/"
  end
end