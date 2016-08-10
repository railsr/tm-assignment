class SessionsController < ApplicationController

  def new
    redirect_to root_url if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      if user.is_admin?
        redirect_to admin_dashboard_tasks_path
      else
        redirect_to dashboard_tasks_path(user)
      end
    else
      flash[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to dashboard_tasks_path
  end
end
