class CreateEventExperienceChoices < ActiveRecord::Migration
  def self.up
    create_table :event_experience_choices do |t|
      t.references :event_experience
      t.references :event_option
      t.timestamps
    end    
  end

  def self.down
    drop_table :event_experience_choices
  end
end