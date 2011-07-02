ActionMailer::Base.smtp_settings = {  
  :address              => "mail.sotaca1898.com",  
  :port                 => 26,  
  :domain               => "sotaca1898.com",  
  :user_name            => "no-reply+sotaca1898.com",  
  :password             => "Triangle.Sotaca",  
  :authentication       => "plain",  
}


#ActionMailer::Base.smtp_settings = {  
#  :address              => "smtp.gmail.com",  
#  :port                 => 587,  
#  :domain               => "gmail.com",  
#  :user_name            => "tmaximini@gmail.com",  
#  :password             => "sum3mer05",  
#  :authentication       => "plain",  
#  :enable_starttls_auto => true  
#}