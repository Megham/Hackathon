class ApplicationController < ActionController::Base
  helper_method :gmail_username
  @@gmail_user = nil

  def set_gmail_user(user)
    @@gmail_user = user
    session["gmail_user"] = user.username
  end

  def gmail_username
    session["gmail_user"]
  end

  protect_from_forgery
  http_basic_authenticate_with :name => "mughil", :password => "hackathon"
end
