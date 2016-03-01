MyApp.get "/" do
  erb :"home"
end

MyApp.get "/logins/new" do
  erb :"logins/new"
end

MyApp.post "/logins/create" do
  
end

MyApp.post "/logins/:id/delete" do
  
end