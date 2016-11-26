class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(get_user_params)

  	if @user.save
      login @user
  		redirect_to root_path
  	else
      @user.errors.full_messages.each do |e|
        flash[:danger] = e
      end
  		redirect_to root_path
  	end
  end

  def show
    if loggedIn? && !currentUser.isAdmin
      @user = currentUser
    elsif loggedIn? && currentUser.isAdmin
      redirect_to admin_path
    else
      redirect_to login_path
    end
  end

  def adminShow
    if loggedIn? && currentUser.isAdmin
        @users = User.all
        @user = currentUser
    else
      redirect_to login_path
    end
  end

  def update

    if currentUser.update(get_user_update_params)
      redirect_to root_path
    else
      currentUser.errors.full_messages.each do |e|
        flash[:danger] = e
      end
      redirect_to root_path
    end

  end

  private

	  def get_user_params
	  	params.require(:user).permit(:email, :firstName, :lastName, :password, :password_confirmation)
	  end

    def get_user_update_params
      params.require(:user).permit(:email, :firstName, :lastName)
    end

end
