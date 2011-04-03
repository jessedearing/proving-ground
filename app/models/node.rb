class Node < ActiveRecord::Base
  has_many :comments
  scope :top5, limit("0, 5")
  scope :published, where("publish_date IS NOT NULL")

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
