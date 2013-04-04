#use Rack::Session::Pool, :expire_after => 2592000

get '/' do
  @user = session[:user]
  # Look in app/views/index.erb
  erb :index
end

post '/login' do
  email = params[:email]
  password = params[:password]  

  user = User.authenticate(email, password)
  session[:user] = user
  redirect to("/")
end

post '/signup' do
  email = params[:email]
  name = params[:name]
  password = params[:password]

  user = User.create(:name => name, :email => email, :password => password)
  session[:user] = user
  redirect to('/')

end

get '/logout' do
  session.delete(:user)
  redirect to('/')
end  


