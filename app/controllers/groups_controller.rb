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

  def add_user
    userid = params[:adduser]
    @group = Group.find(params[:groupid])
    @user = User.find(userid)

    @group = Group.find(params[:groupid])
    #Add user without immediately committing to the database
    @group.association(:users).send(:build_through_record, @user) unless @group.users.include? @user
    @group.save(validate: false)

    #Just in case I need my beautiful ajax again :'(
    #respond_to do |format|
    #  format.json {render json: userArray}
    #end
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
      format.json {render json: @Group.users}
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to root_path
  end

  def save_locations
    @group = Group.find(params[:id])

    params[:locations].each do |l|
      @group.locations.create(:address => l)
    end

  end

  private
    def get_group_params
      params.require(:group).permit(:gname, :user_ids => [])
    end
end
