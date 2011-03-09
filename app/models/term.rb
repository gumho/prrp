class Term < ActiveRecord::Base
  has_many :proposals
  has_many :campus_winners
end
