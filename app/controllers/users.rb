MyApp.get "/users" do
  erb :"users/index"
end

MyApp.get "/users/:id" do
  erb :"users/show"
end

MyApp.get "/users/new" do
  erb :"users/new"
end

MyApp.post "/users/create" do
  
end

MyApp.get "/users/:id/edit" do
  erb :"users/edit"
end

MyApp.post "/users/:id/update" do
  
end

MyApp.post "/users/:id/delete" do
  
end