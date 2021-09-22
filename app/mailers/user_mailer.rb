class UserMailer < ApplicationMailer
  def welcome_email(user)
    # @ 为了在模板中可以访问
    @user = user
    @url  = 'https://yym.com'
    mail(to: @user.email, subject: '欢迎来到杨雨蒙的邮件世界')
  end
end
