class Node < ActiveRecord::Base
  has_many :comments

  def comment_count
    comment_ct = 0
    comments.each do |comment|
      comment_ct += 1 if comment.is_complete?
    end
    comment_ct
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
