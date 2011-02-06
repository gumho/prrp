class Proposal < ActiveRecord::Base
  belongs_to :user
  has_many :documents
  
  accepts_nested_attributes_for :documents, :allow_destroy => true 
end
