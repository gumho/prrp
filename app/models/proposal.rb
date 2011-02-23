class Proposal < ActiveRecord::Base
  belongs_to :user
  belongs_to :term
  has_many :documents
  
  accepts_nested_attributes_for :documents, :allow_destroy => true 
  
  def self.search(params)
    Proposal.paginate :page => params[:page], 
      :joins => [:user => :organization],
      :per_page => 5,
      :order => sort_conditions(params[:sort_by], params[:order])
  end
  
  def self.sort_conditions(sort_by, order)
    if sort_by == 'author'
      "users.first_name #{order}"
    elsif sort_by == 'organization'
      "organizations.name #{order}"
    elsif sort_by == 'reviewed'
      "proposals.reviewed"
    else
      "#{sort_by} #{order}"
    end
  end
  
end
