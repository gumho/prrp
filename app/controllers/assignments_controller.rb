class AssignmentsController < ApplicationController
  
  before_filter :auth
  
  def multi_update
    json = ActiveSupport::JSON.decode(params[:data])
    json['proposals'].each do |proposal|
      Assignment.where("proposal_id = #{proposal['id']}").destroy_all
      proposal['reviewers'].each do |reviewer|
        ass = Assignment.new(:proposal_id => proposal['id'], 
          :user_id => reviewer,
          :term => current_term)
        ass.save
      end
    end    
    
    respond_to do |format|
      format.json  { render :json => "{'success': 'true'}" }
    end
  end
  
  def auth
    authorize! :assign, :proposals
  end
end