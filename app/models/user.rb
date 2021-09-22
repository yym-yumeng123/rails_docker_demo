class User < ApplicationRecord
  has_secure_password
  # model 里面对数据进行验证

  # emial 永远存在
  validates_presence_of :email
  # 邮箱唯一性
  validates_uniqueness_of :email
  # 确认密码 create时存在
  validates_presence_of :password_confirmation, on: [:create]
  # 验证 email 格式
  validates_format_of :email, with: /.+@.+/, if: :email
  # 验证密码长短
  validates_length_of :password, minimum: 6, on: :create, if: :password

  # 发送邮件
  after_create :send_welcome_email 
  def send_welcome_email
    # 让 UserMailer 在保存之后发送一封欢迎邮件
    UserMailer.welcome_email(self).deliver_now
  end
end
