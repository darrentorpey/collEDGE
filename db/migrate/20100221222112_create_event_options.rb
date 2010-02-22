class CreateEventOptions < ActiveRecord::Migration
  def self.up
    create_table :event_options do |t|
      t.references :event
      t.string     :text
      t.timestamps
    end    
  end

  def self.down
    drop_table :event_options
  end
end