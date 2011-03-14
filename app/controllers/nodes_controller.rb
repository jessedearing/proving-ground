class NodesController < ApplicationController
  def index
    @posts = Post.order(:publish_date).reverse_order()
  end

  def show
    @post = Post.where(:id => params[:id])[0]
  end
end
