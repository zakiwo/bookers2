class SendMailsController < ApplicationController

  def show
    @email = SendMail.find(params[:id])
  end

  def new
    @group = Group.find(params[:group_id])
    @email = SendMail.new
  end

  def create
    @group = Group.find(params[:group_id])
    @email = SendMail.new(send_mail_params)
    @email.group_id = @group.id
    if @email.save
      @group_users = @group.group_users
      @group_users.each do |group_user|
        SendMailer.with(user_email: group_user.user.email, title: @email.title, body: @email.body, owner_email: current_user.email).send_email.deliver_now
      end
      redirect_to group_send_mail_path(@group, @email)
    else
      render 'new'
    end
  end

  private
  def send_mail_params
    params.require(:send_mail).permit(:title, :body)
  end
end
