module NodesHelper
  def post_path(id)
    node_path(id)
  end

  def title(title)
    content_for :title, " - #{title}"
  end
end
