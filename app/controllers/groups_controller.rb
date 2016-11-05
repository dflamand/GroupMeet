class GroupsController < ApplicationController
  
  def index
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(get_group_params)
    @group.users << currentUser
    @group.groupowner = currentUser.id
    
    if @group.save
      redirect_to @group
    else
      render('new')
    end
  end
  
  def show
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to currentUser
  end
  
  private
    def get_group_params
      params.require(:group).permit(:gname)
    end
end
