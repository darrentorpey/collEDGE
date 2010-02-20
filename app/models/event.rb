class Event < ActiveRecord::Base
  attr_accessible :date, :name, :properties_list

  # Other ideas
  #=> boundary_buster...
  #=> metaphysical_exploration...
  bitmask :properties, :as => {
    1 => :romantic,
    2 => :fun,
    3 => :exciting,
    4 => :envigorating,
    5 => :eye_opening,
    6 => :enlightening,
    7 => :hard,
    8 => :emotionally_challenging,
    9 => :one_off,
    }.values

  # bitmask :properties, :as => {
  #   1 => :snowball_fight,
  #   2 => :great_talk,
  #   3 => :all_nighter,
  #   4 => :explore_the_town,
  #   5 => :romantic_encounter,
  #   6 => :throwing_disk,
  #   7 => :game_fest
  #   }.values

  attr_accessor :properties_list
  before_save :decode_properties

  def properties_list
    properties.join(' ')
  end

  private

  def decode_properties
    if @properties_list
      self.properties = @properties_list.gsub(',', '').split(/\s+/).inject([]) do |coll, name|
        coll << name.to_sym
      end
    end
  end
end

class RomanticEncounter < Event
end