class InvitesController < ApplicationController

  def create
    testing = params.require(:invite).permit(:user_email, :group_id)
    @user = User.find_by_email(testing[:user_email])
    @invite = Invite.new
    @invite.user_id = @user.id
    @invite.group_id = params[:group_id]
    @invite.save
  end

  private
    def get_invite_params
      params.require(:invite).permit(:user_email, :group_id)
    end
end
