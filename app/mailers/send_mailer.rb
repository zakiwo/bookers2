class SendMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def send_email
    @user_email = params[:user_email]
    @title = params[:title]
    @body = params[:body]
    @owner_email = params[:owner_email]
    mail(from: @owner_email,
         to: @user_email,
         subject: @title)
  end
end
