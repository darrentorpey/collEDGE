class AddResultToEventOptions < ActiveRecord::Migration
  def self.up
    add_column :event_options, :result, :text
  end

  def self.down
    remove_column :event_experience_choices, :result
  end
end
