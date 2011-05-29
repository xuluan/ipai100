class SyncJob < Struct.new(:site, :message, :content)
  def perform
    client = OauthWrapper.get_oauth_obj(site.site_name).load(:access_token => site.token, :access_token_secret => site.secret)
    if message.pic.present?
      client.upload_image(content, message.pic.path)
    else
      client.add_status(content)
    end
  end
end