module NodesHelper
  def post_path(id)
    node_path(id)
  end

  def title(title)
    content_for :title, " - #{title}"
  end

  def paging(total_post_count, size)
    if(total_post_count > POSTS_ON_FRONT_PAGE && size == POSTS_ON_FRONT_PAGE)
      '<div class="grid_16">' +
      link_to("Next >>", root_path(:page => params[:page].nil? ? 2 : params[:page].to_i + 1)) +
      '</div>'
    end
  end
end
