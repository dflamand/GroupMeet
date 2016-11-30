class InvitesController < ApplicationController

  def create
    @invite = Invite.new(get_invite_params)
  end

  private
    def get_invite_params
      params.require(:invite).permit(:group_id, :user_id)
    end
end
