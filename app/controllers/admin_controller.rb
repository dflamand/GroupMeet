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
		@regUser = User.find(params[:id])
	end

	def showGroup
		@group = Group.find(params[:id])
	end

end
