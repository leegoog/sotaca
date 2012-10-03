class UserMailer < ActionMailer::Base
  default :from => "no-reply@sotaca1898.com"
  
  def registration_confirmation(user)  
    mail(:to => user.email, :subject => "Registered", :from => "no-reply@sotaca1898.com")  
  end
  
end
