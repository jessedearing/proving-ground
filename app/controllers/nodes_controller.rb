class NodesController < ApplicationController
  before_filter :verify_authenticated, :only => [:new, :edit, :create, :update]

  def index
    start_row = 5 * (params[:page].nil? ? 0 : params[:page].to_i - 1)
    if start_row > 0
      @posts = Post.published.limit("#{start_row}, 5").order(:publish_date).includes(:comments).reverse_order
    else
      @posts = Post.top5.published.order(:publish_date).includes(:comments).reverse_order
    end
    @total_post_count = Post.published.size
  end

  def show
    @post = Post.where(:id => params[:id]).first
  end

  def old_show
    @post = Post.where(:id => params[:id].to_i - 2).first
    render :action => 'show'
  end

  def edit
    @node = Node.find params[:id]
  end

  def new
    @node = Node.new(:publish_date => Time.now)
  end

  def create
    if params[:node][:type] == "post"
      @node = Post.new params[:node]
    else
      @node = Page.new params[:node]
    end

    @node.publish_date = Time.now

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

  def rss
    @nodes = Post.top5.published.order(:publish_date).reverse_order
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  private

  def verify_authenticated
    if session[:authenticated_as] != :admin
      redirect_to root_path
    end
  end
end
