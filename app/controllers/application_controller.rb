class ApplicationController < ActionController::API
  private
  # 使用会话中 :current_user_id  键存储的 ID 查找用户
  # Rails 应用经常这样处理用户登录
  # 登录后设定这个会话值，退出后删除这个会话值
  def current_user
    @_current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end


  # 返回结果处理
  def render_resources(resource)
    return head 404 if resource.nil?
    # 可以把结果包装一下
    if resource.errors.empty?
      render json: {resources: resource}, status: 200
    else
      render json: {errors: resource.errors}, status: 400
    end
  end
end
