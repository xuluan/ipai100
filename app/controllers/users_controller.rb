class UsersController < ApplicationController
  skip_before_filter :require_login

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "注册!"
    else
      render "new"
    end
  end

  def update_info

    @user = current_user
    @user_info = @user.user_info

    if request.method == "POST"
      @user_info.nickname =  params[:user_info][:nickname]
      @user_info.description = params[:user_info][:description]
      @user_info.photo = params[:user_info][:photo] if params[:user_info][:photo]
      @message = "已保存！" if @user_info.save

    end

    render "info"

  end


  def update_pwd
    @user = current_user

    if request.method == "POST"

      if params[:password] == params[:password_confirmation]
        @user.password = params[:password]
        if @user.save
          @message = "更改密码成功！"
        end
      else
        @user.errors.add(:base, "两次密码输入不一致，请重新输入。")
      end

    end

    render "pwd"

  end
end
