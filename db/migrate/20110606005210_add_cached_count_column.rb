class AddCachedCountColumn < ActiveRecord::Migration
  def self.up
    add_column :nodes, :comments_count, :integer
    Node.find_each do |node|
      node.comments_count = node.comments.count
      node.save
    end
  end

  def self.down
    remove_column :nodes, :comments_count
  end
end
