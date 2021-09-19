class UsersController < ApplicationController
  # 处理用户 ajax 请求
  def create
    #:email 表示一个简短的字符串 or symbol
    p params[:email]
    p params[:password]

    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    user.save

    p user.errors
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
