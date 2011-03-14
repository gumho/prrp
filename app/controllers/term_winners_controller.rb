class TermWinnersController < ApplicationController
  
  before_filter :auth
  
  def index
    @winners = TermWinner.where("term_id = #{current_term.id}")
    
    @proposals = Proposal.paginate :page => params[:page],
      :per_page => 20,
      :conditions => "term_id = #{current_term.id}"
  end
  
  def create
    @winner = TermWinner.find_or_create_by_term_id_and_proposal_id(:term_id => current_term.id, :proposal_id => params[:proposal_id])
    if @winner.save
      redirect_to term_winners_path, :notice => 'Winner succesfully selected!'
    end
  end
  
  def destroy
    @winner = TermWinner.find(:all,
      :conditions => "term_id = #{current_term.id} AND proposal_id = #{params[:proposal_id]}").first
    @winner.destroy
    
    redirect_to term_winners_path, :notice => 'Winner was successfully un-selected!'
  end
  
  def auth
    authorize! :pick, :winners
  end
end
