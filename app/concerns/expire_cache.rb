module ExpireCache
  def expire_posts_cache(id = nil)
    id = params[:id] if id.nil?
    # expire_fragment({:action => 'show', :controller => 'nodes', :id => id})
    expire_fragment("node#{id}")
    expire_fragment({:action => 'index', :controller => 'nodes'})
  end
end
