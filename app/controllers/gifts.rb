MyApp.get "/gifts" do
  erb :"gifts/index"
end

MyApp.get "/gifts/new" do
  erb :"gifts/new"
end

MyApp.post "/gifts/create" do
  
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