class EventExperienceChoice < ActiveRecord::Base
  belongs_to :event_experience
  belongs_to :event_option

  def option; event_option; end

  def result
    event_option.result
  end
end