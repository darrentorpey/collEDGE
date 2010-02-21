class ExperienceChoice < ActiveRecord::Base
  belongs_to :experience
  belongs_to :option
end