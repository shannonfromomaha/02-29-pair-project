MyApp.get "/" do
  erb :"home"
end

MyApp.get "/logins/new" do
  erb :"logins/new"
end

MyApp.post "/logins/create" do
  @user = User.find_by_email(params[:email])
  if @user == nil
    redirect "/users/new"
  elsif @user.password == params[:password]
    session["user_id"] = @user.id
    redirect "/users/#{@user.id}"
  else
    redirect "/logins/new"
  end
end

MyApp.post "/logins/:id/delete" do
  
end