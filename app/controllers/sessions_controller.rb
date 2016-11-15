class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:user][:email])
  	if user && user.authenticate(params[:user][:password])
  		login user
      puts "You are now logged in. Current user is " + currentUser.email + "\n"
  		#redirect_to user
  	else
  		render 'new'
  	end
  end

  def destroy
  	logOut
  	redirect_to root_path
  end

end
