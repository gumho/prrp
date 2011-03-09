class CampusWinnersController < ApplicationController
  
  before_filter :auth
  
  def index
    if current_term
      t_id = current_term.id
    else
      t_id = ''
    end
    @winners = CampusWinner.paginate :page => params[:page], 
      :joins => [:term, :organization],
      :per_page => 20,
      :conditions => ['terms.id = ? AND organizations.id = ?', t_id, current_user.organization_id]
  end
  
  def auth
    authorize! :elect, :proposals
  end

end
