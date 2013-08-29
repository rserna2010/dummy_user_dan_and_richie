get '/' do
  if logged_in?
    redirect to '/secret'
  else
    erb :index
  end
end

get '/secret' do
  if logged_in?
    erb :secret
  else
    @status = "You must provide login information to view that page."
    redirect to "/#{@status}"
  end
end

post '/login' do
#figuring out how create a session
  @user_id = User.authenticate(params[:email], params[:password])
  begin
    log_in(@user_id)
  rescue Exception => e
    message = e.message
  end

  if message
    redirect to "/#{message}"
  else
    redirect to '/secret'
  end
end

get '/logout' do 
  log_out
  redirect to '/'
end

post '/users' do
 

  begin
    if confirm_password?(params[:password], params[:password_confirmation])
      user = User.create!(name: params[:name], email: params[:email], password: params[:password])
      log_in(user.id)
      outcome = redirect to '/secret'
    else
      @message = "Password confirmation failed. Please try again."
      @name = params[:name]
      @email = params[:email]
      outcome =redirect to "/users/new/#{@message}/#{@name}/#{@email}"
    end

  rescue Exception => e
    @message = e.message 
  end

  if @message
    @message 
    @name = params[:name]
    @email = params[:email]
    erb :create_user
  else 
    outcome
  end
end

get '/users/new' do 
  erb :create_user
end

get '/users/new/:message/:name/:email' do
  @name = params[:name]
  @email = params[:email]
  @message = params[:message]
  erb :create_user
end

get '/:status' do
  @status = params[:status]
  erb :index
end
