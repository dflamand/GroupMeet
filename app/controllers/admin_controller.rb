class AdminController < ApplicationController

	def index
	    if loggedIn? && currentUser.isAdmin
	        @users = User.all
	        @user = currentUser
	    else
	      redirect_to login_path
	    end
	end

end
