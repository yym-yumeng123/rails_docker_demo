class SessionsController < ApplicationController
  def create_params
    params.permit(:email, :password)
  end

  def create
    s = Session.new create_params
    s.validate
    render_resources s
    session[:current_user_id] = s.user.id
  end

  def destroy
  
  end
end
