class TermWinner < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :term
end
