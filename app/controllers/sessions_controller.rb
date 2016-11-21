class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:user][:email])
  	if user && user.authenticate(params[:user][:password])
  		login user
      puts "You are now logged in. Current user is " + currentUser.email + "\n"
  		if !user.isAdmin
        redirect_to root_path
      else
        redirect_to admin_index_path
      end
  	else
      flash[:danger] = 'invalid email/password'
  		redirect_to root_path
  	end
  end

  def destroy
  	logOut
  	redirect_to root_path
  end

end
