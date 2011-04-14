class Node < ActiveRecord::Base
  has_many :comments
  scope :top5, limit("0, 6")
  scope :published, where("nodes.publish_date < ?", Time.now)

  # Produces a count of the comments
  #
  # Other methods for counts are available, but this one
  # does not run a query for each node if Node has an includes
  # method
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
