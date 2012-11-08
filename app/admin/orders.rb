ActiveAdmin.register Order do
  
  scope :new_orders
  
  index do
    column :id
    column :order_nr
    column "Order Date", :created_at
    column :order_status
    column :last_name
    column :first_name
    column :street
    column :zipcode
    column :city
    column "Articles" do |order|
      div :class => "cart" do
        link_to pluralize(order.cart.total_items, "item"), order
      end  
    end
    column "Price" do |order|
      div :class => "price" do
        number_to_currency(order.total_price.to_money.exchange_to("GBP"))
      end  
    end
    column :ip_address
    default_actions
  end

  filter :order_status  
  filter :order_nr
  filter :created_at, :label => "Order Date"
  filter :zipcode
  filter :city
  filter :last_name
  filter :ip_address
  
  
  show do
    h3 order.order_nr
    pluralize(order.cart.total_items, "item")
    render "cart", :locals => {:order => order}
  end
  
end