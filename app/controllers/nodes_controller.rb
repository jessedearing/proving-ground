class NodesController < ApplicationController
  include ExpireCache
  before_filter :verify_authenticated, :only => [:new, :edit, :create, :update]

  def index
    start_row = POSTS_ON_FRONT_PAGE * (params[:page].nil? ? 0 : params[:page].to_i - 1)
    if start_row > 0
      @posts = Post.published.offset(start_row).limit("#{POSTS_ON_FRONT_PAGE}").order('nodes.publish_date').includes(:comments).reverse_order
    else
      @posts = Post.top_posts.published.order('nodes.publish_date').includes(:comments).reverse_order
    end
    @total_post_count = Post.published.size
    if(@total_post_count < (params[:page].to_i * POSTS_ON_FRONT_PAGE) && @posts.empty?)
      render :text => 'No more posts', :status => 404
    end
  end

  def show
    @post = load_node(params[:id])
  end

  def old_show
    head :moved_permanently, :location => node_path(params[:id].to_i - 2)
  end

  def edit
    @node = Node.find params[:id]
  end

  def new
    @node = Node.new(:publish_date => Time.now)
  end

  def create
    @node = case params[:node][:type]
    when 'post' then Post.new params[:node]
    when 'page' then Page.new params[:node]
    end

    if @node.save
      expire_posts_cache(@node.id)
      redirect_to root_path
    end
  end

  def update
    @node = Node.find params[:id]
    @node.update_attributes params[:post]

    if @node.save
      expire_posts_cache(@node.id)
      redirect_to root_path
    end
  end

  def rss
    @nodes = Post.top_posts.published.order(:publish_date).reverse_order
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  private

  def verify_authenticated
    if session[:authenticated_as] != :admin
      redirect_to root_path
    end
  end

  def load_node(id)
    Post.where(:id => id).first
  end
end
