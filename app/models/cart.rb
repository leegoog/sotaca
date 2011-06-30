class Cart < ActiveRecord::Base
    attr_accessible :id, :purchased_at, :line_items
    
    has_many :line_items, :dependent => :destroy
    
    has_one :order
    
    attr_accessor :total_price, :full_price
    
    # returns the cart's total price
    def total_price
      line_items.to_a.sum { |item| item.full_price }
    end
    
    # generates an url with article names and prices as parameters to checkout with paypal
    def paypal_encrypted(return_url, notify_url)
        values = {
          :business => APP_CONFIG[:paypal_email],
          :cmd => '_cart',
          :upload => 1,
          :return => return_url,
          :invoice => id,
          :notify_url => notify_url,
          :currency_code => 'GBP',
          :cert_id => APP_CONFIG[:paypal_cert_id]
        }
        line_items.each_with_index do |item, index|
          values.merge!({
            "amount_#{index+1}" => item.unit_price,
            "item_name_#{index+1}" => item.product.title,
            "item_number_#{index+1}" => item.id,
            "quantity_#{index+1}" => item.quantity
          })
       end
     encrypt_for_paypal(values)
    end
    
    
    # adds an item to the cart
    def add_item(product, price)
      current_item = line_items.where(:product_id => product).first
      if current_item
        current_item.quantity += 1
        current_item.save
      else
        line_items.create!(:product_id => product, :quantity => 1, :unit_price => price)
      end
    end
    
    # returns the number of total items of the cart
    def number_of_items
      line_items.count > 0 ? "#{line_items.count} item(s)" : "empty"
    end
     
     PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")  
     APP_CERT_PEM = File.read("#{Rails.root}/certs/sotaca_cert.pem")  
     APP_KEY_PEM = File.read("#{Rails.root}/certs/sotaca_key.pem")  
     
     # encrypts the cart's line items to process the checkout with paypal, using paypal's public certificate and our public and private key
     def encrypt_for_paypal(values)  
         signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM),
         OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''),
         values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)  
         
         OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)],
         signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"),
         OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")  
     end
     
    
end
