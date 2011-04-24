class Comment < ActiveRecord::Base
  belongs_to :node
  validates_presence_of :body, :email, :name
  scope :complete, where(:is_complete => true)

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
end
