class AddIndexesToPostsAndComments < ActiveRecord::Migration
  def self.up
    add_index :nodes, :type
    add_index :nodes, :publish_date
    add_index :comments, :node_id
  end

  def self.down
    remove_index :nodes, :type
    remove_index :nodes, :publish_date
    remove_index :comments, :node_id
  end
end
