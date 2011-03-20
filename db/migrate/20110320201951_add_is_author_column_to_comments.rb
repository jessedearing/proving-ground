class AddIsAuthorColumnToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :is_author, :boolean, :null => false
  end

  def self.down
    remove_column :comments, :is_author
  end
end
