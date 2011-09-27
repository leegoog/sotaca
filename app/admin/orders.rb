ActiveAdmin.register Order do
  index do
    column :id
    column :order_nr
    column "Order Date", :created_at
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
    column :ip_address
    default_actions
  end
  
  filter :order_nr
  filter :created_at, :label => "Order Date"
  filter :zipcode
  filter :city
  filter :last_name
  filter :ip_address
end
