#require 'net/http'
#require 'multipart'
require 'rubygems'

require 'rest_client'

HTTP_PREFIX = "http://"
SERVER_URL = "127.0.0.1:3000/"
LOGIN_PATH = "shop_api/login"
UPLOAD_PATH = "shop_api/publish"

#
#response  = RestClient.get url2

def login(id, password)
    url = HTTP_PREFIX+id+":"+password+"@"+SERVER_URL+LOGIN_PATH
    response = RestClient.get url
	puts response

end


def upload(id, password, content, pic, shop)
    url = HTTP_PREFIX+id+":"+password+"@"+SERVER_URL+UPLOAD_PATH

	response = RestClient.post url, :message_pic => File.new(pic, 'rb'), :message_context => content, :shop_id =>shop
		
	puts response
end

def help
	puts "ruby shop_action.rb login <phoneid> <password>"
	puts "ruby shop_action.rb upload <phoneid> <password> <message> <upload_picture> <shop_phoneid>"
	exit
end	

help if ARGV.size < 1
action = ARGV.shift

if action == 'login'
  if ARGV.size == 2
    login(*ARGV)
  else
    help
  end
elsif action == 'upload'
  if ARGV.size == 5
    upload(*ARGV)
  else
    help
  end   
end
