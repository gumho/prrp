class CampusWinner < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :term
  belongs_to :organization
  
  include ActiveModel::Validations
  
  class MaximumElectsValidator < ActiveModel::Validator
    def validate(record)
      num_elects = CampusWinner.where("term_id = ? AND organization_id = ?", 1, 2).count
      # FIXME: put this into an application config
      if num_elects == 8
        record.errors[:base] << "Already at the maximum amount of elected proposals!"
      end
    end
  
  end
  
  validates_with MaximumElectsValidator
end

