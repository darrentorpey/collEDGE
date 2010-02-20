class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :key
      t.string :password
      t.integer :roles_mask, :default => 0
      t.timestamps
    end
  end
  
  def self.down
    drop_table :users
  end
end
