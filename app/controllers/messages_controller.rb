class MessagesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @messages = Message.find_all_by_user_id(session[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @messages }
    end
  end

  def list
    @messages = Message.find_all_by_user_id(session[:user_id])
    puts @messages

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    @message.user_id = session[:user_id]

    respond_to do |format|
      if @message.save
        context = truncate("[ "+ message_url(@message) + " ] "+ @message.context, :length => 140)

        current_user.sync_sites.each do |site|
          client = OauthWrapper.get_oauth_obj(site.site_name).load(:access_token => site.token, :access_token_secret => site.secret)
          if @message.pic.present?
            client.upload_image(context, @message.pic.path)
          else
            client.add_status(context)
          end

        end

        format.html { redirect_to(@message, :notice => '文章已发布!') }
        format.xml { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(@message, :notice => '文章已更新.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml { head :ok }
    end
  end
end
