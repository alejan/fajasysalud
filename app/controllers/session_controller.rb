class SessionController < ApplicationController
  def new
    @user=User.new
  end

  def create
  user = User.find_by(username: params[:username])
  if user and user.authenticate(params[:password])
  session[:role_name]=Role.find_by(employee_id: params[:user.employee_id]).name
  redirect_to admin_path
  else
  redirect_to root_path, alert: "Invalid user/password combination"
  end
  end

  def destroy
  session[:role_name]=nil
  redirect_to login_url, notice: "Logged out"
  end
end
