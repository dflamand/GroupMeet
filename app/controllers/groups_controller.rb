class GroupsController < ApplicationController
  
  def index
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(get_group_params)
    
    if @group.save
      redirect_to @group
    else
      render('new')
    end
  end
  
  private
    def get_group_params
      params.require(:group).permit(:gname)
    end
end
