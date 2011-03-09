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
    
    # if term is the 'current' term, destroy that
    current = CurrentTerm.all.first
    if current
      if @term.id == current.id
        current.destroy
      end
    end
    
    # lastly, destroy the term
    @term.destroy
    
    redirect_to terms_path, :notice => 'Term was successfully destroyed'
  end
  
  def set_current
    
  end
  
  def unset_current
    
  end
  
  def activate
    term = current_term.term
    term.active = true
    if term.save
      redirect_to terms_path, :notice => 'Term was successfully activated'
    end
  end
  
  def deactivate
    term = current_term.term
    term.active = false
    if term.save
      redirect_to terms_path, :notice => 'Term was successfully de-activated'
    end
  end
  
  def auth
    authorize! :manage, :terms
  end
end
