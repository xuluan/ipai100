class ShopApiController < ApplicationController
  include ActionView::Helpers::TextHelper

  skip_before_filter :require_login
  before_filter :api_authenticate
  def login
    render :json => "OK"
  end

  def publish
    msg = {"content" => params[:message_content], "pic" => params[:message_pic]}
    message = Message.new(msg)
    message.user_id = @user.id

    if message.save
        content = truncate("[ "+ message_url(message) + " ] "+ message.content, :length => 140)
        puts "url="+message_url(message)

        @user.sync_sites.each do |site|
          Delayed::Job.enqueue(SyncJob.new(site, message, content))
        end
      render :json => "OK"

    else
      render :json => "Fail"
    end

  end


  def api_authenticate
    authenticate_or_request_with_http_basic do |phone_no, password|
    #authenticate_with_http_basic  do |phone_no, password|
      puts "#{phone_no}, #{password},"
      @user = User.authenticate(phone_no, password)
    end
  end
end
