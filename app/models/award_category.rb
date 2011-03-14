class AwardCategory < ActiveRecord::Base
  has_many :proposals
end
