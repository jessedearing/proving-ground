class NodesController < ApplicationController
  include ExpireCache
  before_filter :verify_authenticated, :only => [:new, :edit, :create, :update]

  def index
    start_row = POSTS_ON_FRONT_PAGE * (params[:page].nil? ? 0 : params[:page].to_i - 1)
    if start_row > 0
      @posts = Post.published.limit("#{start_row}, #{POSTS_ON_FRONT_PAGE}").order('nodes.publish_date').includes(:comments).reverse_order
    else
      @posts = Post.top_posts.published.order('nodes.publish_date').includes(:comments).reverse_order
    end
    @total_post_count = Post.published.size
  end

  def show
    @post = load_node(params[:id])
  end

  def old_show
    @post = load_node(params[:id].to_i - 2)
    render :action => 'show'
  end

  def edit
    @node = Node.find params[:id]
  end

  def new
    @node = Node.new(:publish_date => Time.now)
  end

  def create
    @node = Node.new params[:node]

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
    id = id.to_s
    if Rails.cache.read("node#{id}")
      # Dummy call to load Post class so that Marshal.load works
      Post.class
      post = Marshal.load(Rails.cache.read("node#{id}"))
    else
      post = Post.where(:id => id).first
      Rails.cache.write("node#{id}", Marshal.dump(post))
    end
    post
  end
end
