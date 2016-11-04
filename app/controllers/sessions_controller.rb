class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:user][:email])
  	if user && user.authenticate(params[:user][:password])
  		login user
  		redirect_to '/map.html'
  	else
  		render 'new'
  	end
  end


end
