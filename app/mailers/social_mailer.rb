class SocialMailer < ActionMailer::Base
  default :from => "info@sotaca1898.com"  

  def social_share
    attachments.inline['logo.png'] = File.read('public/images/logo.png')
    mail(:to => order.user.email, :subject => "Someone wants to show this to you")  
  end
end
