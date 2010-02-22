class EventOption < ActiveRecord::Base
  belongs_to :event_experience

  def essence_text  
    "#{text}... \t\t#{result}"
  end
end