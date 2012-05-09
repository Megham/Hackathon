class ApplicationController < ActionController::Base
  helper_method :gmail_username
  protect_from_forgery
  http_basic_authenticate_with :name => "mughil", :password => "hackathon"

  def set_gmail_user(username)
    session["mughil_gmail_user"] = username
  end

  def gmail_username
    session["mughil_gmail_user"]
  end

  def sign_out
    session["mughil_gmail_user"] = nil
  end

end
