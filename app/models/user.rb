class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :comments
  has_many :proposals
  belongs_to :role
  belongs_to :organization
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset_instructions(self).deliver
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    UserMailer.confirm_account_instructions(self).deliver
  end
  
  def deliver_welcome!
    UserMailer.welcome_message(self).deliver
  end
  
  def activate!
    self.active = true
    save
  end
  
  def self.search(params)
    User.paginate :page => params[:page],
      :joins => :organization,
      :per_page => 30,
      :conditions => search_conditions(params)
  end
  
  def self.search_conditions(params)
    if params[:user_organization_id]
      "organization_id = '#{params[:user_organization_id]}'"
    end
  end
  
  
end
