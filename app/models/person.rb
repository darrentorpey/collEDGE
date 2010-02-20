class Person < ActiveRecord::Base
  attr_accessible :first_name, :middle_name, :last_name, :nick_name, :gender, :birth_date
end
