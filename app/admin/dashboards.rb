ActiveAdmin::Dashboards.build do


  section "Recent Orders" do  
    table_for Order.order("created_at desc").limit(10) do  
      column :order_nr do |order|  
        link_to order.order_nr, admin_order_path(order)  
      end  
      column :created_at 
      column :order_status 
      column "Articles" do |order|
        div :class => "cart" do
          link_to pluralize(order.cart.total_items, "item"), order
        end  
      end
      column "Price" do |order|
        div :class => "price" do
          number_to_currency(order.cart.total_price)
        end  
      end
    end  
    strong { link_to "View All Orders", admin_orders_path }  
  end
  
  section "Newest Registrations" do  
    table_for User.order("created_at desc").limit(5) do  
      column :id  
      column :created_at  
      column :username
      column :email
    end  
    strong { link_to "View All Users", admin_users_path }  
  end
  
  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
