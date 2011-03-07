class CampusWinnersController < ApplicationController
  
  before_filter :auth
  
  def index
    @winners = CampusWinner.where("term_id = ? AND organization_id = ?", CurrentTerm.all.first.id, current_user.organization_id)
  end
  
  def auth
    authorize! :elect, :proposals
  end

end