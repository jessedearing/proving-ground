module NodesHelper
  def seoize(title)
    title.gsub(' ', '-').gsub("'", '-').gsub(':', '-').
      gsub('?', '-').gsub('/', '-').gsub('#', '-').
      gsub('.', '')
  end

  def post_path(id)
    node_path(id)
  end
end
