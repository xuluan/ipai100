class ShopApiController < ApplicationController

  skip_before_filter :require_login
  before_filter :api_authenticate
  def login
    render :json => "OK"
  end

  def create
  end


  def api_authenticate
    authenticate_or_request_with_http_basic do |phone_no, password|
    #authenticate_with_http_basic  do |phone_no, password|
      puts "#{phone_no}, #{password},"
      User.authenticate(phone_no, password)
    end
  end
end
