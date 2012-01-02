class CommentsController < ApplicationController
  include ReCaptcha::AppHelper
  include ExpireCache

  def index
  end

  def show
  end

  def new
    @comment = Comment.new
    cookies[:recap] = false
    render :layout => false
  end

  def create
    @comment = Comment.new(params[:comment])
    save_comment
  end

  def update
    @comment = Comment.where({:node_id => params[:node_id], :id => params[:id], :is_complete => false}).first
    @comment.update_attributes params[:comment]
    save_comment
  end

  def edit
    @comment = Comment.where({:node_id => params[:node_id], :id => params[:id], :is_complete => false}).first
    render :layout => false
  end

  def delete
  end

  private

  def save_comment
    if params[:comment_title].empty?
      @comment.node_id = params[:node_id]
      @comment.is_author = session[:authenticated_as] == :admin
      begin
        @recaptcha = validate_recap(params, @comment.errors)
        if(@comment.save_with_recap(@recaptcha))
          expire_posts_cache(params[:node_id])
          redirect_to node_path(params[:node_id]) + "#comment-#{@comment.id}"
        else
          cookies[:recap] = @recaptcha
          redirect_to node_path(params[:node_id], :comment_id => @comment.id)
        end
      rescue Exception => e
        logger.warn "Caught #{e.exception} on ReCaptcha"
        cookies[:recap] = @recaptcha
        redirect_to node_path(params[:node_id], :comment_id => @comment.id)
      end
    end
  end

end
