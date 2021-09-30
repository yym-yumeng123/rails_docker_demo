class TagsController < ApplicationController
  before_action :must_sign_in

  def create
    render_resources Tag.create create_params.merge user: current_user
  end

  def destroy
    tag = Tag.find(params[:id])
    head tag.destroy ? :ok : :bad_request
  end

  def index
    render_index_resources  Tag.page(params[:page]).per(params[:per_page])
  end

  def show
    render_resources Tag.find(params[:id])
  end

  def update
    tag = Tag.find(params[:id])
    tag.update(create_params)
    render_resources tag
  end

  private
  def create_params
    params.permit(:name)
  end
end
