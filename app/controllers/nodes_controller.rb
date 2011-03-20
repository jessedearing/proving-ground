class NodesController < ApplicationController
  before_filter :verify_authenticated, :except => [:index, :show, :rss, :old_show]
  caches_page :new
  caches_action :show, :rss, :if => lambda {session[:authenticated_as] != :admin}
  caches_action :index, :if => lambda {params[:page].nil? && session[:authenticated_as] != :admin}

  def index
    start_row = 5 * (params[:page].nil? ? 0 : params[:page].to_i - 1)
    @posts = Post.where("publish_date IS NOT NULL").order(:publish_date).includes(:comments).limit([start_row, 5]).reverse_order
    @total_post_count = Post.where("publish_date IS NOT NULL").count
  end

  def show
    @post = Post.where(:id => params[:id]).first
    @subtitle = @post.title
    @comments = @post.comments.where(:is_complete => true)
  end

  def old_show
    params[:id] = params[:id].to_i - 2
    @post = Post.where(:id => params[:id]).first
    @subtitle = @post.title
    @comments = @post.comments.where(:is_complete => true)
    render :action => 'show'
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
      expire_action :action => :index
      redirect_to root_path
    end
  end

  def update
    @node = Node.find params[:id]
    @node.update_attributes params[:post]

    if @node.save
      expire_action :action => [:index,:show]
      redirect_to root_path
    end
  end

  def rss
    @nodes = Post.where("publish_date IS NOT NULL").order(:publish_date).limit([0, 5]).reverse_order
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
