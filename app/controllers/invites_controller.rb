class InvitesController < ApplicationController

  def create
    iparams = params.require(:invite).permit(:user_email, :group_id)
    @user = User.find_by_email(iparams[:user_email])
    @group = Group.find_by(params[:groupid])

    if not @group.users.include? @user
      @invite = Invite.new

      @invite.user_id = @user.id
      @invite.group_id = @group.id
      @invite.gname = @group.gname
      @invite.save
    end
  end

  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy
  end
end
