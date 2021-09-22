class ApplicationController < ActionController::API
  # 返回结果处理
  def render_resources(resource)
    # 可以把结果包装一下
    if resource.errors.empty?
      render json: {resources: resource}, status: 200
    else
      render json: {errors: resource.errors}, status: 400
    end
  end
end
