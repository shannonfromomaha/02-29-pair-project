MyApp.get "/users" do
  @user = User.find_by_id(session["user_id"])
  session["current_page"] = "/users"
  if @user == nil
    redirect "/logins/new"
  else
    @users = User.all
    erb :"users/index"
  end
end

MyApp.get "/users/new" do
  @errors = session["errors"]
  session["errors"] = nil
  session["current_page"] = "/users"
  erb :"users/new"
end

MyApp.post "/users/create" do
  @user = User.new
  @user.name = params["name"]
  @user.email = params["email"]
  @user.password = params["password"]
  if @user.is_valid == true
    @user.save
    # sends an email to the new user about their new account
    @user.new_user_email
    session["user_id"] = @user.id
    redirect "/users/#{@user.id}"
  else
    session["errors"] = @user.get_errors
    redirect "/users/new"
  end
end

MyApp.get "/users/:id" do
  @user = User.find_by_id(session["user_id"])
  session["current_page"] = "/users"
  @created_gifts = Gift.where("user_id" => params[:id])
  @pledged_gifts = @user.pledged_gifts
  if @user == nil
    redirect "/logins/new"
  else
    @user = User.find_by_id(params[:id])
    erb :"users/show"
  end
end

MyApp.get "/users/:id/edit" do
  @user = User.find_by_id(session["user_id"])
  session["current_page"] = "/users"
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