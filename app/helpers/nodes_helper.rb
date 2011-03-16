module NodesHelper
  def seoize(title)
    title.gsub(' ', '-').gsub("'", '-').gsub(':', '-').
      gsub('?', '-').gsub('/', '-').gsub('#', '-')
  end
end
