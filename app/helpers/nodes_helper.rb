module NodesHelper
  def post_path(*args)
    node_path(*args)
  end

  def title(title)
    content_for :title, " - #{title}"
  end

  def paging(total_post_count)
      ret = '<div class="grid_16" id="pagination">'
    if(total_post_count > (POSTS_ON_FRONT_PAGE * (params[:page].nil? ? 1 : params[:page].to_i)))
      if params[:page].to_i > 0
      ret += link_to("<< Previous ", node_page_path(params[:page].nil? ? 2 : params[:page].to_i - 1))
      else
      end
      ret += link_to(" Next >>", node_page_path(params[:page].nil? ? 2 : params[:page].to_i + 1))
    end
    ret += '</div>'
  end
end
