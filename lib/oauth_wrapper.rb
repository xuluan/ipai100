
require "oauth_china"

class OauthWrapper
  private
  @@site_hash = {:sina => OauthChina::Sina, :douban => OauthChina::Douban, :qq => OauthChina::Qq,
                 :sohu => OauthChina::Sohu, :netease => OauthChina::Netease }

  public
  def self.get_oauth_obj(type)
    return @@site_hash[type.to_sym]
  end
end
