MyApp.get "/pledges" do
  erb :"pledges/index"
end

MyApp.get "/pledges/:id" do
  erb :"pledges/show"
end

MyApp.get "/pledges/new" do
  erb :"pledges/new"
end

MyApp.post "/pledges/create" do
  
end

MyApp.get "/pledges/:id/edit" do
  erb :"pledges/edit"
end

MyApp.post "/pledges/:id/update" do
  
end

MyApp.post "/pledges/:id/delete" do
  
end