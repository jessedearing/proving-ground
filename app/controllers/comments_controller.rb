class CommentsController < ApplicationController
  include ReCaptcha::AppHelper

  def index
  end

  def show
    # @comment = Comment.where({:node_id => params[:node_id], :id => params[:id]}).first
    # if @comment.is_complete
    #   redirect_to root_path
    # else
    #   @comment_action = 'update'
    #   render :action => 'new', :layout => false
    # end
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
      @comment.is_complete = true
      @recaptcha = validate_recap(params, @comment.errors)
      if(!(@recaptcha && @comment.save))
        cookies[:recap] = @recaptcha
        @comment.is_complete = false
        @comment.save false
        redirect_to "/nodes/#{params[:node_id]}?comment_id=#{@comment.id}&#comment_new"
      else
        redirect_to "/nodes/#{params[:node_id]}#comment-#{@comment.id}"
      end
    end
  end

end
