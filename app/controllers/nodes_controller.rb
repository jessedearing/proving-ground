class NodesController < ApplicationController
  before_filter :require_login, :only => [:new, :edit, :create, :update]

  caches_page :show, :index, :rss

  def index
    start_row = POSTS_ON_FRONT_PAGE * (params[:page].nil? ? 0 : params[:page].to_i - 1)
    if start_row > 0
      @posts = Post.published.offset(start_row).limit("#{POSTS_ON_FRONT_PAGE}").order('nodes.publish_date').reverse_order
    else
      @posts = Post.top_posts.published.order('nodes.publish_date').reverse_order
    end
    @total_post_count = Post.published.size
    if(@posts.all.empty?)
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
      expire_page :action => :index
      expire_page :action => :rss
      redirect_to root_path
    end
  end

  def update
    @node = Node.find params[:id]
    @node.update_attributes params[:post]

    if @node.save
      expire_page :action => :show
      expire_page :action => :index
      expire_page :action => :rss
      redirect_to node_path(@node.to_param)
    end
  end

  def rss
    @nodes = Post.top_posts.published.order(:publish_date).reverse_order
    respond_to do |format|
      format.xml
    end
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  def comments
    @post = load_node(params[:id])
    render :layout => false
  end

  private

  def load_node(id)
    Post.find(id)
  end
end
