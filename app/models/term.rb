class Term < ActiveRecord::Base
  has_many :proposals
  has_many :campus_winners
  has_many :term_winners
  has_many :letters
end
