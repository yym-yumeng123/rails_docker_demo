class TagsController < ApplicationController
  before_action :must_sign_in

  def create
    render_resources Tag.create create_params
  end

  private
  def create_params
    params.permit(:name)
  end
end
