class ProposalsController < ApplicationController
  
  before_filter :require_owner, :except => [:show, :review, :elect, :unelect]
  before_filter :require_owner_or_review, :only => [:show]
  before_filter :require_no_submissions_current_term, :only => [:new, :create]
  
  # GET /users/1/proposals
  # GET /users/1/proposals.xml
  def index
    @user = User.find(params[:user_id])
    @proposals = @user.proposals.all
  end

  # GET /users/1/proposals/1
  # GET /users/1/proposals/1.xml
  def show
    @user = User.find(params[:user_id])
    @proposal = @user.proposals.find(params[:id])
    @comment = @proposal.comments.new
  end

  # GET /users/1/proposals/new
  # GET /users/1/proposals/new.xml
  def new
    # Don't show page if term is not active
    if !current_term
      flash[:error] = "Sorry, the current term is not active yet!"
      redirect_to root_path
      return
    end
    
    @user = User.find(params[:user_id])
    
    @proposal = Proposal.new
    @proposal.documents.build
  end

  # GET /proposals/1/edit
  def edit
    @user = User.find(params[:user_id])
    @proposal = Proposal.find(params[:id])
  end

  # POST /proposals
  # POST /proposals.xml
  def create
    @user = User.find(params[:user_id])
    @proposal = @user.proposals.create(params[:proposal])
    
    if @proposal.save
      redirect_to(user_proposal_path(@user, @proposal), :notice => 'Proposal was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /proposals/1
  # PUT /proposals/1.xml
  def update
    @user = User.find(params[:user_id])
    @proposal = @user.proposals.find(params[:id])

    if @proposal.update_attributes(params[:proposal])
      redirect_to(user_proposal_path(@user, @proposal), :notice => 'Proposal was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.xml
  def destroy
    @user = User.find(params[:user_id])
    @proposal = @user.proposals.find(params[:id])
    @proposal.destroy

    redirect_to user_proposals_path
  end
  
  def review
    authorize! :review, :proposals
    
    # campus level users cannot see other organizations' proposals
    # CHECKME: Does reviewer_organization get set into the response params in view?
    if current_user.role.name == 'campus admin' || current_user.role.name == 'campus reviewer'
      params[:reviewer_organization] = current_user.organization.name
    end
    
    @proposals = Proposal.search(params)
  end
  
  def elect
    authorize! :elect, :proposals
    @proposal = Proposal.find(params[:id])
    @campus_winner = @proposal.elect(current_term.id, @proposal.id, params[:organization_id])
    
    if @campus_winner.errors.count > 0
      flash[:error] = @campus_winner.errors[:base]
    else
      flash[:notice] = "Proposal has been successfully elected!"
    end
    
    redirect_to user_proposal_path(@proposal.user, @proposal)
  end
  
  def unelect
    authorize! :elect, :proposals
    @proposal = Proposal.find(params[:id])
    @campus_winner = @proposal.unelect(current_term.id, @proposal.id)
    if @campus_winner != nil
      flash[:notice] = "Proposal was successfully un-elected!"
    else
      flash[:error] = "Proposal was not elected to begin with!"
    end
    redirect_to user_proposal_path(@proposal.user, @proposal)
  end
  
  private
  
  # Redirect if user has already submitted this term
  def require_no_submissions_current_term
    user_proposals_this_term = Proposal.where("user_id = ? AND term_id = ?", params[:user_id], current_term).count
    if user_proposals_this_term >= 1
      flash[:error] = 'You have already submitted a proposal this term!'
      redirect_to user_proposals_path(@user)
    end
  end
  
  def require_owner
    if params[:user_id] != current_user.id.to_s
      flash[:notice] = "You do not have access to this page"
      redirect_to user_proposals_path(current_user)
    end
  end
  
  def require_owner_or_review
    if (params[:user_id] == current_user.id.to_s) || (can? :review, :proposals)
    else
      flash[:notice] = "You do not have access to this page"
      redirect_to user_proposals_path(current_user)  
    end
  end
  
  
end
