class ProposalsController < ApplicationController
  
  before_filter :require_owner, :except => [:show, :review]
  before_filter :require_owner_or_review, :only => [:show]
  
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
    @documents = @proposal.documents.all
  end

  # GET /users/1/proposals/new
  # GET /users/1/proposals/new.xml
  def new
    if !current_term
      flash[:notice] = "Sorry, the current term is not active yet."
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

    redirect_to(user_proposals_path)
  end
  
  def review
    authorize! :review, :proposals
    @proposals = Proposal.search(params)
  end
  
  private
  
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
