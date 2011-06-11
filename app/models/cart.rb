class Cart < ActiveRecord::Base
    attr_accessible :id, :purchased_at, :line_items
    
    has_many :line_items, :dependent => :destroy
    
    attr_accessor :total_price, :full_price
    
    def total_price
      line_items.to_a.sum { |item| item.full_price }
    end
    
    def paypal_url(return_url, notify_url)
        values = {
          :business => 'seller_1307044964_per@trianglecollective.com',
          :cmd => '_cart',
          :upload => 1,
          :return => return_url,
          :invoice => id,
          :notify_url => notify_url,
          :currency_code => 'GBP'
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
    
    def add_item(product, price)
      current_item = line_items.where(:product_id => product).first
      if current_item
        current_item.quantity += 1
        current_item.save
      else
        line_items.create!(:product_id => product, :quantity => 1, :unit_price => price)
      end
    end
     
    
end
