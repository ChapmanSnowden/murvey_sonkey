get '/login' do
  erb :login
end

post '/login' do
  user = User.authenticate(params[:name], params[:password])
  session[:user_id] = user.id if user
  redirect '/'
end

post '/sign_up' do
  user = User.new(name: params[:name], email: params[:email])
  user.password = params[:password]

  user.save
 
  session[:user_id] = user.id if user.id
  redirect '/'
end

get '/logout' do
  session.clear
  redirect '/'
end
