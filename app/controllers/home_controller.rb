require "net/http"
require "uri"

class HomeController < ApplicationController
  require "gmail"

  def index
  end

  def add_user
    raise params.inspect
    begin
      set_gmail_user(params["username"])
    rescue
      @error = "Login Failed" 
      render :login
      return
    end
    params["name"] = "" if params["name"] == "Nick Name"
    email_suffix = params["username"] =~ %r{^.+@.+$}? "" : "@gmail.com"
    User.find_or_create_by_email(email: params["username"] + email_suffix, name: params["name"])
    redirect_to new_idea_path
  end

  def login
    raise params.inspect
    uri = URI.parse("https://www.googleapis.com/oauth2/v1/userinfo?access_token=#{params["code"]}") 
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    re = http.request(Net::HTTP::Get.new(uri.request_uri))
    raise re.body.inspect
  end

  def logout
    sign_out
    redirect_to root_path
  end
end
