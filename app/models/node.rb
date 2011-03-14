class Node < ActiveRecord::Base
  has_many :comments

  def seo_title
    self.title.gsub(' ', '-').
      gsub("'", '').
      gsub("!", "")
  end
end
