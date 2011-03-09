class TermsController < ApplicationController
  
  before_filter :auth
  
  def show
    @term = Term.find(params[:id])
  end
  
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
    
    # un-set old
    if current_term
      old = current_term
      old.active = false
      old.save
    end
    
    if @term.save
      redirect_to terms_path, :notice => 'Term successfully created!'
    else
      flash[:error] = 'An error occured'
    end
  end
  
  def destroy
    @term = Term.find(params[:id])
    @term.destroy
    
    redirect_to terms_path, :notice => 'Term successfully destroyed!'
  end
  
  def edit
    @term = Term.find(params[:id])
  end
  
  def update
    @term = Term.find(params[:id])
    if @term.update_attributes(params[:term])
      redirect_to term_path(@term), :notice => "Term successfully updated!"
    else
      render :action => 'edit'
    end
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
    else
      flash[:error] = 'An error occured'
      redirect_to terms_path
    end
  end
  
  def suspend
    term = Term.find(params[:id])
    term.active = false
    if term.save
      redirect_to terms_path, :notice => 'Term was successfully suspended!'
    else
      flash[:error] = 'An error occured'
      redirect_to terms_path
    end
  end
  
  def auth
    authorize! :manage, :terms
  end
end
