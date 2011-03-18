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
    @node = Node.find params[:id]
  end
  
  def new
    @node = Node.new
  end

  def create
    if params[:node][:type] == "post"
      @node = Post.new params[:node]
    else
      @node = Page.new params[:node]
    end

    if @node.save
      redirect_to root_path
    end
  end

  def update
    @node = Node.find params[:id]
    @node.update_attributes params[:post]

    if @node.save
      redirect_to root_path
    end
  end

  private

  def verify_authenticated
    if session[:authenticated_as] != :admin
      redirect_to root_path
    end
  end
end
