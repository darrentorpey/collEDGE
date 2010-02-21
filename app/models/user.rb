class User < ActiveRecord::Base

  has_many :event_experiences
  has_many :events, :through => :event_experiences

  bitmask :traits, :as => Trait::ALL_TRAIT_NAMES

  before_create :generate_key

  attr_protected          :password

  validates_format_of     :email, :with => /\w*@\w*.com/
  validates_length_of     :email, :in => 1..100
  validates_uniqueness_of :email, :case_sensitive => false

  # Roles
  ROLES_MASK = {
    1 => :admin,
    2 => :moderator,
    3 => :user
  }.values
  easy_roles :roles_mask, :method => :bitmask

  def self.generate_examples(num = 10)
    (1..num).collect do |i|
      User.new(:email => "generated_#{i}@gmail.com", :traits => Trait.pick_trait_set.map(&:name)).short_report
    end
  end

  def short_report
    "#{email}\t\t#{trait_report}"
  end

  def trait_report
    traits.map(&:to_s).sort.map { |t| t.gsub('_', '-').capitalize }.join(', ')
  end

  def assign_traits
    update_attribute(:traits, Trait.pick_trait_set.map(&:name))
  end
end