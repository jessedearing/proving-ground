require 'digest/sha1'

class AdminController < ApplicationController
  def signin
  end

  def authenticate
    if login(params[:username], params[:password])
      redirect_to root_path
    else
      redirect_to '/jd/a/login'
    end
  end

  def signout
    logout
    redirect_to root_path
  end
end
