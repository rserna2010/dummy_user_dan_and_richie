helpers do
  
  def log_in(user_id)
    puts "THIS IS RUNNING"
    User.find(user_id)
    puts "USER ID: #{@user_id}"
    session[:user_id] = user_id
  end

  def log_out
    session[:user_id] = false
  end

  def logged_in?
    session[:user_id] != false
  end

  def return_user
    User.find(session[:user_id])
  end

  def confirm_password?(password, password_confirmation)
    password == password_confirmation
  end

end
