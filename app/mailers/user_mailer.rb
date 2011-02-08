class UserMailer < ActionMailer::Base
  default :from => "noreply@prrp.com"
  
  def password_reset_instructions(user)
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token, :host => "localhost:3000")

    mail(:to => user.email,
         :subject => "PRRP - Reset Your Password")
  end
  
  def confirm_account_instructions(user)
    @account_activation_url = activate_url(user.perishable_token, :host => "localhost:3000")
    mail(:to => user.email,
         :subject => "PRRP - Confirm Your Account")
  end
  
  def welcome_message(user)
    mail(:to => user.email,
         :subject => "PRRP - Welcome!")
  end
end
