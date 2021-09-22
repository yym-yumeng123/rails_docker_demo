class ApplicationMailer < ActionMailer::Base
  # 一个散列，该邮件程序发出邮件的默认设置
  # :from 邮件头设为一个值，这个类中的所有动作都会使用这个值，不过可以在具体的动作中覆盖
  default from: '1614527443@qq.com'
  layout 'mailer'
end
