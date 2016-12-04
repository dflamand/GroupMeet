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

    if @group.save
      redirect_to root_path
    else
      render('new')
    end
  end


  def remove_user
    @group = Group.find(params[:groupid])
    @user = User.find(params[:userid])

    if @group && @user
      @user.groups.delete(@group)
      if currentUser == @user
        redirect_to root_path
      else
        respond_to do |format|
          format.json {render json: @user}
        end
      end
    end
  end

  def show
    @Group = Group.find(params[:id])

    respond_to do |format|
      format.json {render :json => {:owner => currentUser.id == @Group.groupowner, :users => @Group.users}}
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to root_path
  end

  def save_locations
    @group = Group.find(params[:id])

    @group.clear_locations

    params[:address].each_with_index do |a, i|
      @group.locations.create(:address => a, :tMode => params[:modes][i])
    end
  end

  def load_locations
    @group = Group.find(params[:id])

    @locations = @group.locations

    respond_to do |format|
      format.json {render json: @locations}
    end

  end

  private
    def get_group_params
      params.require(:group).permit(:gname, :user_ids => [])
    end
end
