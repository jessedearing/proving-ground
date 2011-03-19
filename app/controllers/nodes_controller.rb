class NodesController < ApplicationController
  before_filter :verify_authenticated, :except => [:index, :show, :rss]

  def index
    start_row = 5 * (params[:page].nil? ? 0 : params[:page].to_i - 1)
    @posts = Post.where("publish_date IS NOT NULL").order(:publish_date).limit([start_row, 5]).reverse_order
    @total_post_count = Post.select("count(*) as total_count").where("publish_date IS NOT NULL").first.total_count.to_i
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
