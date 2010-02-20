class User < ActiveRecord::Base

  # Mass-assignment protection
  attr_protected          :password
  attr_readonly           :key

  # Validations
  validates_format_of     :email, :with => /\w*@\w*.com/
  validates_length_of     :email, :in => 1..100
  validates_uniqueness_of :email, :case_sensitive => false
  validates_length_of     :key, :is => 20, :message => "key must be 20 characters long"

  # AR lifecyle callbacks
  before_create :generate_key

  # Roles
  ROLES_MASK = {
    1 => :admin,
    2 => :moderator,
    3 => :user
  }.values
  easy_roles :roles_mask, :method => :bitmask

  private

  def generate_key
    if self.key.blank?
      api_key_salt = password.blank? ? Time.now.to_s : password
      self.key = Digest::SHA1.hexdigest("--#{api_key_salt}--#{email}--").first(20)
    end
  end
end