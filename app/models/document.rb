class Document < ActiveRecord::Base  
  belongs_to :proposal
  
  has_attached_file :doc
  
end
