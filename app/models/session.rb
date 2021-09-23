class Session
  include ActiveModel::Model
  attr_accessor :email, :password, :user

  validates :email, presence: true
  # validate 不加s, 自定义校验
  validate :check_email, if: :email
  
  validates :password, presence: true
  # 校验密码 email 密码 都存在, 校验密码
  validate :email_password_match, if: Proc.new { |s| s.email.present? and s.password.present? }
  validates_format_of :email, with: /.+@.+/, if: :email
  validates_length_of :password, minimum: 6, if: :password


  def check_email
    # user = user || User.find_by ==>
    @user ||= User.find_by email: email
    # 如果 user 为 空
    if user.nil?
      errors.add :email, :not_found
    end
  end

  def email_password_match
    @user ||= User.find_by email: email
    # 如果 用户存在 并且 密码不对
    if user and not user.authenticate(password)
      errors.add :password, :missmatch
    end
  end
end