class Notifier < ActionMailer::Base
  default :from => "info@sotaca1898.com"  
  
  def contact_notification(sender)
     @sender = sender
     mail(:to => "leegoo.guo@gmail.com",
          :from => sender.email,
          :subject => "New #{sender.support_type} - Message from Sotaca1898")
  end
  
  
end
