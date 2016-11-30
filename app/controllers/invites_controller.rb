class InvitesController < ApplicationController

  def create
    iparams = params.require(:invite).permit(:user_email, :group_id)
    @user = User.find_by_email(iparams[:user_email])
    @invite = Invite.new
    @invite.user_id = @user.id
    @invite.group_id = params[:group_id]
    @invite.save
  end
end
