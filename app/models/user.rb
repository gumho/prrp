class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :proposals
  has_one :role
  
end
