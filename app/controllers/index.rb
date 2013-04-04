get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/login' do
  email = params[:email]
  password = params[:password]  

  auth = User.authenticate(email, password)
  p auth


end

post '/signup' do
  email = params[:email]
  name = params[:name]
  password = params[:password]

  User.create(:name => name, :email => email, :password => password)

  redirect to('/')

end
