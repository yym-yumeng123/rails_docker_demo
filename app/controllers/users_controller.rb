class UsersController < ApplicationController
  # 处理用户 ajax 请求
  def create
    #:email 表示一个简短的字符串 or symbol
    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    # 可以把结果包装一下
    if user.save
      render json: {resources: user}, status: 200
    else
      render json: {errors: user.errors}, status: 400
    end
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
