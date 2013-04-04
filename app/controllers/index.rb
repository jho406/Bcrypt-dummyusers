
get '/' do
  # let user create new short URL, display a list of shortened URLs
  @links = Link.limit(5)
  erb :index
end

get '/logout' do
  session.delete(:user_id)
  redirect to("/")
end

post '/signup' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  redirect to("/user/#{user.id}")
end

get '/users/:id' do
  @user = current_user
  @links = current_user.links
  erb :profile
end

post '/users/:id/links/new' do
  x=current_user.links.create(:url=>params[:url])
  redirect to("/users/#{current_user.id}")
end

post '/signin' do
  cred = params[:user]
  user = User.authenticate(cred[:email], cred[:password])
  session[:user_id] = user.id
  redirect to("/")
end

get '/' do
  @user = session[:user]
  erb :index
end

get '/:short_url' do
  p params[:short_url]
  pass if params[:short_url].chomp.blank?
  link = Link.find_by_short_url(params[:short_url])
  link.increment!(:click_count)
  redirect to(link.url)
end
