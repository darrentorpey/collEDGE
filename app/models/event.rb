class Event < ActiveRecord::Base

  has_many :event_experiences
  has_many :users, :through => :event_experiences

  attr_accessible :date, :name, :properties_list

  PROPERTIES = {
    1  => :romantic,
    2  => :fun,
    3  => :exciting,
    4  => :invigorating,
    5  => :eye_opening,
    6  => :enlightening,
    7  => :hard,
    8  => :emotionally_challenging,
    9  => :one_off,
    10 => :boundary_busting,
    11 => :metaphysical
  }

  bitmask :properties, :as => PROPERTIES.values

  attr_accessor :properties_list
  before_save :decode_properties

  def properties_list
    properties_list_sorted.join(', ')
  end

  def properties_list_sorted
    properties.map(&:to_s).sort
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