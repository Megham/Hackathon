require "net/http"
require "uri"
require "json"

class HomeController < ApplicationController

  def index
  end

  def login
    token_url = URI.parse('https://accounts.google.com/o/oauth2/token')
    token_req = Net::HTTP::Post.new(token_url.path)
    token_req.set_form_data({ 'code' => params['code'], 'client_id' => APP_CONFIG["client_id"], 'client_secret' => APP_CONFIG["client_secret"], 'redirect_uri' => APP_CONFIG["redirect_uri"], 'grant_type' => 'authorization_code' })
    token_http = Net::HTTP.new(token_url.host, token_url.port)
    token_http.use_ssl = true
    token_response_json = token_http.request(token_req)
    token_response = JSON.parse(token_response_json.body)
    access_token = token_response["access_token"]
 
    url = URI.parse("https://www.googleapis.com/oauth2/v1/userinfo?fields=email,name&access_token=#{access_token}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url.request_uri)
    response_json = http.request(request)
    response = JSON.parse(response_json.body)
    @email = response["email"]
    @name = response["name"]
    User.find_or_create_by_email(email: @email, name: @name)
    set_gmail_user(@email)
    redirect_to root_path
  end

  def logout
    sign_out
    redirect_to root_path
  end
end
