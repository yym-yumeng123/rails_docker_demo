class Session
  include ActiveModel::Model
  attr_accessor :email, :password

  validates :email, presence: true
  # validate 不加s, 自定义校验
  validate :check_email, if: :email

  validates :password, presence: true
  validates_format_of :email, with: /.+@.+/, if: :email
  validates_length_of :password, minimum: 6, if: :password


  def check_email
    user = User.find_by email: email
    # 如果 user 为 空
    if user.nil?
      errors.add :email, :not_found
    end
  end
end