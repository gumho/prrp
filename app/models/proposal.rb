class Proposal < ActiveRecord::Base
  belongs_to :user
  belongs_to :term
  belongs_to :award_category
  
  has_many :documents
  has_many :comments
  accepts_nested_attributes_for :documents, :allow_destroy => true 
  
  def elect(term_id, proposal_id, organization_id)
    @campus_winner = CampusWinner.find_or_create_by_proposal_id_and_term_id(:proposal_id => proposal_id,
      :term_id => term_id, :organization_id => organization_id)
  end
  
  def unelect(term_id, proposal_id)
    @campus_winner = CampusWinner.where("term_id = ? AND proposal_id = ?", term_id, proposal_id).first
    if @campus_winner != nil
      @campus_winner.destroy
    end
  end
  
  
  
  def self.search(params)
    Proposal.paginate :page => params[:page], 
      :joins => [:user => :organization],
      :per_page => 20,
      :order => sort_conditions(params[:sort_by], params[:order]),
      :conditions => filter_conditions(params)
  end
  
  def self.sort_conditions(sort_by, order)
    if sort_by == 'author'
      "users.first_name #{order}"
    elsif sort_by == 'organization'
      "organizations.name #{order}"
    elsif sort_by == 'reviewed'
      "proposals.reviewed #{order}"
    else
      "#{sort_by} #{order}"
    end
  end
  
  # FIXME: Consider optimizing...the filters later on.
  def self.filter_conditions(params)
    # add more conditions later
    query = []
    query << reviewed_proposals_conditions(params) unless params[:only_unreviewed].blank?
    query << organization_conditions(params) unless params[:reviewer_organization].blank?
    condition = [query.map{|c| c[0] }.join(" AND "), *query.map{|c| c[1..-1] }.flatten]
  end
  
    def self.reviewed_proposals_conditions(params)
      ['proposals.reviewed = ?', true]
    end
  
    def self.organization_conditions(params)
      ['organizations.name = ?', params[:reviewer_organization]]
    end
  
end
