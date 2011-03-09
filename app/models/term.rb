class Term < ActiveRecord::Base
  has_many :proposals
  has_many :campus_winners
  
  # NEED VALIDATION!!!! only one can be active
end
