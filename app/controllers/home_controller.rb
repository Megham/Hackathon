class HomeController < ApplicationController
  require "gmail"

  def index
  end

  def add_user
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
  end

  def logout
    sign_out
    redirect_to root_path
  end
end
