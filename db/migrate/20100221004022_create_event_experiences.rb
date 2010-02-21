class CreateEventExperiences < ActiveRecord::Migration
  def self.up
    create_table :event_experiences do |t|
      t.references :user
      t.references :event
      t.timestamps
    end
  end

  def self.down
    drop_table :event_experiences
  end
end