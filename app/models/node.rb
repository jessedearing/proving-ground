class Node < ActiveRecord::Base
  has_many :comments

  def seo_title
    self.title.gsub(' ', '-').
      gsub("'", '').
      gsub("!", "")
  end

  def comment_count
    comment_ct = 0
    comments.each do |comment|
      comment_ct += 1 if comment.is_complete?
    end
    comment_ct
  end
end
