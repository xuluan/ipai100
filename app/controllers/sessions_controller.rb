class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
  end
  
  def create
    user = User.authenticate(params[:phone_no], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "谢谢，登入！"
    else
      flash.now.alert = "Invalid phone number or password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "谢谢，登出!"
  end
end
