class TaggingsController < ApplicationController
  before_action :must_sign_in

  def create
    render_resources Tagging.create create_params
  end

  def destroy
    tagging = Tagging.find params[:id]
    head tagging.destroy ? :ok : :bad_request
  end

  def index
    render_index_resources Tagging.page(params[:page])
  end

  def show
    render_resources Tagging.find(params[:id])
  end

  private
  def create_params
    params.permit(:record_id, :tag_id)
  end
end
