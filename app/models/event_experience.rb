class EventExperience < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  has_one :event_experience_choice

  def choice; event_experience_choice; end
end