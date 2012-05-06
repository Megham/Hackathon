class HomeController < ApplicationController
  require "gmail"
  def index
  end

  def add_user
    begin
      set_gmail_user( Gmail.connect!(params["username"], params["password"]))
    rescue
      @error = "Login Failed" 
      render :login
      return
    end
    redirect_to new_idea_path
  end

  def login
  end
end
