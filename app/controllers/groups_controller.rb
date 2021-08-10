class GroupsController < ApplicationController
  def index
    @groups = Group.all
    @new_book = Book.new
  end

  def show
    @group = Group.find(params[:id])
    @new_book = Book.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      GroupUser.create(user_id: current_user.id, group_id: @group.id)
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render 'edit'
    end
  end

  def new_mail
    @group = Group.find(params[:group_id])
  end

  def send_mail
    @group = Group.find(params[:group_id])
    @group_users = @group.users
    @title = params[:title]
    @body = params[:body]
    SendMailer.with(group_users: @group_users, title: @title, body: @body).send_email.deliver_now
  end

  def destroy

  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
