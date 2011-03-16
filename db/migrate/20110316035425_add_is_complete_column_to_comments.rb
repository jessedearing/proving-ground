class AddIsCompleteColumnToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :is_complete, :boolean, {:default => false, :null => false}
  end

  def self.down
    remove_column :comments, :is_complete
  end
end
