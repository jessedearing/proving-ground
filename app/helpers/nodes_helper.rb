module NodesHelper
  def post_path(id)
    node_path(id)
  end

  def title(title)
    content_for :title, " - #{title}"
  end

  def paging
    '<div class="grid_16">' +
    link_to("Next >>", root_path(:page => params[:page].nil? ? 2 : params[:page].to_i + 1)) +
    '</div>'
  end
end
