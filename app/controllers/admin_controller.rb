class AdminController < ApplicationController

	def index
	    if loggedIn? && currentUser.isAdmin
	        @users = User.all
	        @user = currentUser
	    else
	      redirect_to login_path
	    end
	end

	def show
		if loggedIn? && currentUser.isAdmin
			@regUser = User.find(params[:id])
		else
			redirect_to login_path
		end
	end

	def showGroup
		if loggedIn? && currentUser.isAdmin
			@group = Group.find(params[:id])
		else
			redirect_to login_path
		end
	end

end
