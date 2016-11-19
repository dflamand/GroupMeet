class GroupsController < ApplicationController

  def index
  end

  def new
    @group = Group.new
    #All users except for the one currently logged in
    #@all_users = User.all.where.not(id: currentUser.id)
  end

  def create
    @group = Group.new(get_group_params)
    @group.users << currentUser
    @group.groupowner = currentUser.id

    puts "***"
    puts @group.users
    puts "***"


    if @group.save
      puts "Group created succesfully"
    else
      render('new')
    end
  end



  def show
    #@group = Group.find(params[:id])
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html
      format.json {render json: @group.users}
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to currentUser, :notice => "Group deleted"
  end

  private
    def get_group_params
      params.require(:group).permit(:gname, :user_ids => [])
    end
end
