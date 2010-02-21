class TraitSet
  attr_accessor :traits, :selected_trait

  def initialize(*args)
    @traits = args
  end

  def select_trait(trait)
    @selected_trait = trait
  end

  def pick_one
    @traits[(0...@traits.size).to_a.rand]
  end

  def name
    @selected_trait.name
  end

  def names
    @traits.map(&:name)
  end
end

def Trait(*args)
  options = args.extract_options!

  if args.size == 1
    Trait.new(args.first.to_s)
  else
    TraitSet.new(*(args.collect { |arg| Trait.new(arg.to_s) }))
  end
end

class Trait < TraitSet

  def initialize(*args)
    name = args.first
    @name = name
    @traits ||= []
    @traits << self
  end

  attr_accessor :name

  def self.pick_trait_set
    TRAITZ.collect(&:pick_one)
  end

  TRAITZ = [
    Trait(:romantic),
    Trait(:lazy),
    Trait(:fun_loving),
    Trait(:extroverted, :introverted),
    Trait(:ambitious, :cautious),
  ]

  ALL_TRAIT_NAMES = TRAITZ.collect(&:names).flatten
end