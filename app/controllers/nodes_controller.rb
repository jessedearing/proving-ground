class NodesController < ApplicationController
  def index
    @posts = Post.where("publish_date IS NOT NULL").order(:publish_date).reverse_order()
  end

  def show
    @post = Post.where(:id => params[:id]).first
  end
end
