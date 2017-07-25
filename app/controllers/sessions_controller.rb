class SessionsController < ApplicationController
  def create
    session = params[:session]
    user = User.find_by email: session[:email].downcase

    if user && user.authenticate(session[:password])
      user_activation user
    else
      flash[:danger] = t "danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
