class GroupsController < ApplicationController
  
  def index
  end
  
  def new
    @group = Group.new
  end
  
  def create
    
    if currentUser.group_id
      raise "You already have a group"
    else
      @group = Group.new(get_group_params)
      @group.users << currentUser
      @group.groupowner = currentUser.id
      
      if @group.save
        redirect_to @group
      else
        render('new')
      end
    end
    
  end
  
  def show
  end
  
  private
    def get_group_params
      params.require(:group).permit(:gname)
    end
end
