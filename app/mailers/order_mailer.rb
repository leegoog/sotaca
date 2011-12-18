class OrderMailer < ActionMailer::Base
  default :from => "info@sotaca1898.com"  

    def order_confirmation(order)  
      @order = order
      mail(:to => order.user.email, :subject => "Order Confirmation - #{order.order_nr}")  
    end
end
