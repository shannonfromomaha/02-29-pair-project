MyApp.get "/users" do
  @users = User.all 
  erb :"users/index"
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
  redirect "/users/#{@user.id}"
end

MyApp.get "/users/:id" do
  @user = User.find_by_id(params[:id])
  erb :"users/show"
end

MyApp.get "/users/:id/edit" do
  @user = User.find_by_id(params[:id]) 
  erb :"users/edit"
end

MyApp.post "/users/:id/update" do
  @user = User.find_by_id(params[:id])
  @user.name = params["name"]
  @user.email = params["email"]
  @user.password = params["password"]
  @user.save
  redirect "/users/#{@user.id}"
end

MyApp.post "/users/:id/delete" do
  @user = User.find_by_id(params[:id]) 
  @user.delete
  erb :"users/delete"
end