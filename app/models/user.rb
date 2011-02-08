class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :proposals
  belongs_to :role
  
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
end
