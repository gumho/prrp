class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :proposals
  belongs_to :role
  
end
