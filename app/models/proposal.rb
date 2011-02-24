class Proposal < ActiveRecord::Base
  belongs_to :user
  belongs_to :term
  has_many :documents
  has_many :comments
  accepts_nested_attributes_for :documents, :allow_destroy => true 
  
  def self.search(params)
    Proposal.paginate :page => params[:page], 
      :joins => [:user => :organization],
      :per_page => 5,
      :order => sort_conditions(params[:sort_by], params[:order]),
      :conditions => filter_conditions(params)
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
  
  def self.filter_conditions(params)
    # add more conditions later
    query = ['proposals.reviewed == ?', true] unless params[:only_unreviewed].blank?
  end
  
end
