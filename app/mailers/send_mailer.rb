class SendMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def send_email
    group_users = params[:group_users]
    @title = params[:title]
    @body = params[:body]
    mail(bcc: group_users.pluck(:email), subject: @title)
  end
end
