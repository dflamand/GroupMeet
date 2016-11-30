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
    userNums = params[:addusers]
    userArray = []
    @group = Group.find(params[:groupid])

    userNums.each do |a|
      aUser = User.find(a)
      userArray.push(aUser) unless @group.users.include? aUser
    end

    @group = Group.find(params[:groupid])
    userArray.each do |sUser|
      #Add user without immediately committing to the database
      @group.association(:users).send(:build_through_record, sUser) unless @group.users.include? sUser

    end

    @group.save(validate: false)

    respond_to do |format|
      format.json {render json: userArray}
    end
  end

  def remove_user
    @group = Group.find(params[:groupid])
    @user = User.find(params[:userid])

    if @group && @user
      @user.groups.delete(@group)
      respond_to do |format|
        format.json {render json: @user}
      end
    end
  end

  def show
    @Group = Group.find(params[:id])

    respond_to do |format|
      format.json {render json: array}
      format.json {render json: @Group}
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to root_path
  end

  private
    def get_group_params
      params.require(:group).permit(:gname, :user_ids => [])
    end
end
