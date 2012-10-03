class OrderMailer < ActionMailer::Base
  default :from => "info@sotaca1898.com"  

    def order_confirmation(order)  
      @order = order
      attachments.inline['logo.png'] = File.read('public/images/logo.png')
      mail(:to => order.user.email, :subject => "Order Confirmation - #{order.order_nr}")  
    end
end
