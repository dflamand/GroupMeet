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
      redirect_to root_path
      puts "Group created successfully"
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

    if @group.save(validate: false)
      puts "GOOD"
    else
      puts "BAD"
    end

    respond_to do |format|
      format.json {render json: userArray}
    end
  end

  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.json {render json: @group.users}
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
