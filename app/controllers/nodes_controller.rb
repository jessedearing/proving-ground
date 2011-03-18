class NodesController < ApplicationController
  before_filter :verify_authenticated, :except => [:index, :show]

  def index
    @posts = Post.where("publish_date IS NOT NULL").order(:publish_date).reverse_order()
  end

  def show
    @post = Post.where(:id => params[:id]).first
    @comments = @post.comments.where(:is_complete => true)
  end

  def edit
  end
end
