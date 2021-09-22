class UsersController < ApplicationController
  # web 传参处理
  def create_params
    # rails 可以省略 return
    # :email 表示一个简短的字符串 or symbol
    params.permit(:email, :password_confirmation, :password)
  end

  # 处理用户 ajax 请求
  def create
    # 先 参数, 再 save, 再 render 结果
    render_resources User.create create_params
  end

  def index
    
  end

  def show
    
  end


  def destroy
    
  end

  def update
    
  end
end
