class UserMailer < ApplicationMailer
  def welcome_email(user)
    # @ 可以在模板里erb使用
    @user = user
    # 自己的网站名字
    @url  = 'http://example.com/login'
    # 用于发送邮件的方法，我们传入了 :to 和 :subject 邮件头
    mail(to: @user.email, subject: '欢迎来到我的世界')
  end
end
