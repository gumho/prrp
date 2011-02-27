class Document < ActiveRecord::Base  
  belongs_to :proposal
  
  has_attached_file :doc
  validates_attachment_presence :doc
end
