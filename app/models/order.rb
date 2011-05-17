class Order < ActiveRecord::Base
    attr_accessible :cart_id, :ip_address, :first_name, :last_name, :street, :house_nr, :zipcode, :city, :country, :card_type, :card_expires_on
end
