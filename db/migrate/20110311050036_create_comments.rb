class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.string :name
      t.string :email
      t.string :url
      t.datetime :publish_date
      t.integer :node_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
