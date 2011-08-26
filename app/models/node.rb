class Node < ActiveRecord::Base
  has_many :comments
  scope :top_posts, limit("#{POSTS_ON_FRONT_PAGE}")
  scope :published, lambda {where("nodes.publish_date < ?", Time.now)}

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
