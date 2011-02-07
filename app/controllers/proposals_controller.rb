class ProposalsController < ApplicationController
  
  # before_filter :require_no_user
  
  # GET /users/1/proposals
  # GET /users/1/proposals.xml
  def index
    @user = User.find(params[:user_id])
    @proposals = @user.proposals.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proposals }
    end
  end

  # GET /users/1/proposals/1
  # GET /users/1/proposals/1.xml
  def show
    @user = User.find(params[:user_id])
    @proposal = @user.proposals.find(params[:id])
    @documents = @proposal.documents.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proposal }
    end
  end

  # GET /users/1/proposals/new
  # GET /users/1/proposals/new.xml
  def new
    @user = User.find(params[:user_id])
    @proposal = Proposal.new
    # 2.times do
      @proposal.documents.build
    # end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proposal }
    end
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

    respond_to do |format|
      if @proposal.save
        format.html { redirect_to(user_proposal_path(@user, @proposal), :notice => 'Proposal was successfully created.') }
        format.xml  { render :xml => @proposal, :status => :created, :location => @proposal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proposals/1
  # PUT /proposals/1.xml
  def update
    @user = User.find(params[:user_id])
    @proposal = @user.proposals.find(params[:id])

    respond_to do |format|
      if @proposal.update_attributes(params[:proposal])
        format.html { redirect_to(user_proposal_path(@user, @proposal), :notice => 'Proposal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.xml
  def destroy
    @user = User.find(params[:user_id])
    @proposal = @user.proposals.find(params[:id])
    @proposal.destroy

    respond_to do |format|
      format.html { redirect_to(user_proposals_path) }
      format.xml  { head :ok }
    end
  end
end
