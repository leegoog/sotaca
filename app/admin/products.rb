ActiveAdmin.register Product do
  index do
    column :product_code
    column :title
    column :category
    column :price, :sortable => :price do |product|
      div :class => "price" do
        number_to_currency(product.price)
      end  
    end
    column "dicontinued", :legacy
    default_actions
  end
  
  filter :title
  filter :price
  filter :category
  filter :product_code  
  
  
  
end
