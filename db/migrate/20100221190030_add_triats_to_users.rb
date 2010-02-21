class AddTriatsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :traits, :integer
  end

  def self.down
    remove_column :users, :traits
  end
end