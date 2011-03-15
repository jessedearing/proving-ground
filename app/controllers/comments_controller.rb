class CommentsController < ApplicationController
  include ReCaptcha::AppHelper

  def index
  end

  def new
    @comment = Comment.new
    render :layout => false
  end

  def create
    @comment = Comment.new(params[:comment])

    if(validate_recap(params, @comment.errors))
       render :text => "passed recaptcha"
    else
       render :text => "failed recaptcha"
    end
  end

  def edit
  end

  def delete
  end

end
