require 'digest/sha1'

class AdminController < ApplicationController
  def login
  end

  def authenticate
    if File.exists? "/etc/jessedearing/admin.yml"
      admin_creds = YAML.load_file("/etc/jessedearing/admin.yml")
    else
      admin_creds = YAML.load_file("#{Rails.root}/config/admin.yml")
    end
    if admin_creds["username"] == params[:username] && admin_creds["password"] == Digest::SHA1.hexdigest(params[:password])
      session[:authenticated_as] = :admin
      redirect_to root_path
    else
      redirect_to '/jd/a/login'
    end
  end

  def logout
    session.delete(:authenticated_as)
    reset_session
    redirect_to root_path
  end
end
