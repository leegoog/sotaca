# factories of my models to be used when testing
  
  
  Factory.define :user do |f|
    f.sequence(:username) { |n| "foo#{n}" }
    f.password "foobar"
    # pass in block so it will always match password
    f.password_confirmation { |u| u.password }
    f.sequence(:email) { |n| "foo#{n}@example.com" }  
    f.admin false 
  end
  
  Factory.define :admin, :parent => "user" do |f|
    f.admin true  
  end 
  
  Factory.define :cart do |f|
    f.association :user
    f.line_items []
  end  
  
  Factory.define :product do |f|
    f.sequence(:title) { |n| "foo#{n}" }
    f.sequence(:subtitle) { |n| "bar#{n}" }
    f.description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    f.sequence(:price) { |n| sprintf("%010d", n) }
  end
  
  Factory.define :set_item do |f|
    f.association :product
    f.association :article_set
  end
  
  
  Factory.define :article_set do |f|
    f.sequence(:name) { |n| "set#{n}" }
    f.sequence(:blog_image) { |n| "image#{n}.png" }
    f.association :user
    f.association :set_item
  end
  

