# sends people home
MyApp.get "/" do
  erb :"homepage"
end

# shows form for new log in
MyApp.get "/logins/new" do
  erb :"logins/new"
end

# processes new log in form
MyApp.post "/logins/create" do
  @user = User.find_by_email(params[:email])
  if @user.nil?
    redirect "/users/new"
  elsif @user.password == params[:password]
    session["user_id"] = @user.id
    redirect "/users/#{@user.id}"
  else
    redirect "/logins/new"
  end
end

# logs user out
MyApp.post "/logins/delete" do
  session["user_id"] = nil
  redirect "/"
end