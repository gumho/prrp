class Letter < ActiveRecord::Base
  belongs_to :term
  
  validates_presence_of :recommender_name, :applicant_relation, :recommender_email,
    :applicant_first_name, :applicant_last_name, :applicant_organization, :content
end
