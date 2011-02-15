class Proposal < ActiveRecord::Base
  belongs_to :user
  belongs_to :term
  has_many :documents
  
  accepts_nested_attributes_for :documents, :allow_destroy => true 
end
