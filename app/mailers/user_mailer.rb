class UserMailer < ActionMailer::Base
  default :from => "noreply@prrp.com"
  
  def password_reset_instructions(user)
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)

    mail(:to => user.email,
         :subject => "PRRP - Reset Your Password")
  end
end
