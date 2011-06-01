class Cart < ActiveRecord::Base
    attr_accessible :id, :purchased_at, :line_items
    
    has_many :line_items, :dependent => :destroy
    
    attr_accessor :total_price, :full_price
    
    def total_price
      line_items.to_a.sum { |item| item.full_price }
    end
    
    def paypal_url(return_url, notify_url)
        values = {
          :business => 'seller_1306933310_biz@trianglecollective.com',
          :cmd => '_cart',
          :upload => 1,
          :return => return_url,
          :invoice => id,
          :notify_url => notify_url  
        }
        line_items.each_with_index do |item, index|
          values.merge!({
            "amount_#{index+1}" => item.unit_price,
            "item_name_#{index+1}" => item.product.title,
            "item_number_#{index+1}" => item.id,
            "quantity_#{index+1}" => item.quantity
          })
       end
      "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    end
    
    
end
