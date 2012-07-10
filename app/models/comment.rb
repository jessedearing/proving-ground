class Comment < ActiveRecord::Base
  belongs_to :node, :counter_cache => true
  validates_presence_of :body, :email, :name
  scope :complete, where(:is_complete => true)
  after_save :update_count
  after_create :update_count

  def save_with_recap(recap)
    if recap
      self.is_complete = true
      save
      true
    else
      self.is_complete = false
      save(false)
      false
    end
  end

  def update_count
    self.node.update_attributes({:comments_count => self.node.comments.complete.count})
  end
end
