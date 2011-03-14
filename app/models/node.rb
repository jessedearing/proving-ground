class Node < ActiveRecord::Base
  def seo_title
    self.title.gsub(' ', '-').
      gsub("'", '').
      gsub("!", "")
  end
end
