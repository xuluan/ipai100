class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :require_login

  protected

  def require_login
    unless User.find_by_id(session[:user_id])
      redirect_to log_in_path , :notice => "请登录！"
    end
  end

  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
