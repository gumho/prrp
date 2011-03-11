class Assignment < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :term
  belongs_to :user
end
