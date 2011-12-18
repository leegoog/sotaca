#ActionMailer::Base.smtp_settings = {  
#  :address              => "mail.sotaca1898.com",  
#  :port                 => 26,  
#  :domain               => "sotaca1898.com",  
#  :user_name            => "no-reply+sotaca1898.com",  
#  :password             => "Triangle.Sotaca",  
#  :authentication       => "plain",  
#}
#

ActionMailer::Base.smtp_settings = {  
  :address              => "smtpout.europe.secureserver.net",  
  :port                 => 80,  
  :domain               => "www.sotaca1898.com",  
  :user_name            => "info@sotaca1898.com",  
  :password             => "redarmy111",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}