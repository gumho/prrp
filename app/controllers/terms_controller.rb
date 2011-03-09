class TermsController < ApplicationController
  
  before_filter :auth

  def index
    @terms = Term.paginate :page => params[:page], 
      :per_page => 20,
      :order => "begin DESC"
  end
  
  def new
    @term = Term.new
  end
  
  def create
    @term = Term.new(params[:term])
    
    if @term.save
      redirect_to terms_path, :notice => 'Term successfully created'
    else
      render :action => "new"
    end
  end
  
  def destroy
    @term = Term.find(params[:id])
    @term.destroy
    
    redirect_to terms_path, :notice => 'Term was successfully destroyed'
  end
  
  def set_current
    # un-set old
    if current_term
      old = current_term
      old.active = false
      old.save
    end
    
    # save the new one
    term = Term.find(params[:id])
    term.active = true
    if term.save
      redirect_to terms_path, :notice => 'Term was successfully set!'
    end
  end
  
  def suspend
    term = Term.find(params[:id])
    term.active = false
    if term.save
      redirect_to terms_path, :notice => 'Term was successfully suspended!'
    end
  end
  
  def auth
    authorize! :manage, :terms
  end
end
