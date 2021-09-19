class User < ApplicationRecord
  has_secure_password
  # model 里面对数据进行验证

  # emial 永远存在
  validates_presence_of :email
  # 确认密码 create时存在
  validates_presence_of :password_confirmation, on: [:create]
  # 验证 email 格式
  validates_format_of :email, with: /.+@.+/
  # 验证密码长短
  validates_length_of :password, :minimum=>6, on: [:create]
end
