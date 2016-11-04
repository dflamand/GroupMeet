module SessionsHelper

	def login(user)
		session[:userID] = user.id
	end

	def currentUser
		if @currentUser.nil?
			@currentUser = User.find_by(id: session[:userID])
		else
			@currentUser
		end
	end

	def loggedIn?
		!currentUser.nil?
	end
end
