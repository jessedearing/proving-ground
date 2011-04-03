class Comment < ActiveRecord::Base
  belongs_to :node
  validates_presence_of :body, :email, :name
  scope :complete, where(:is_complete => true)
end
