class RecordsController < ApplicationController
  # 过滤器
  before_action :must_sign_in

  def create
    # 合并 参数 user
    render_resources Record.create create_params.merge user: current_user
  end

  def destroy
    record = Record.find(params[:id])
    head record.destroy ? :ok : :bad_request
  end

  # 获取所有
  def index
    # 需要分页 page => 第几页 per 一页几条数据, 默认10条
    render_index_resources Record.where("user_id = ?", session[:current_user_id]).page(params[:page]).per(params[:per_page])
  end

  def show
    render_resources Record.find(params[:id])
  end

  def update
    record = Record.find(params[:id])
    record.update(create_params)
    render_resources record
  end

  private

  def create_params
    params.permit(:amount, :category, :notes)
  end

end

