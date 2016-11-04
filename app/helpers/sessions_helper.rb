module SessionsHelper

	def login(user)
		session[:userID] = user.id
	end
end
