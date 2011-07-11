# factories of my models to be used when testing

Factory.define do
  
  
  factory :user do |f|
    f.sequence(:username) { |n| "foo#{n}" }
    f.password "foobar"
    f.password_confirmation { |u| u.password }
    f.sequence(:email) { |n| "foo#{n}@example.com" }  
    admin false 
  end
  
  factory :admin, :class => "user" do |f|
    f.sequence(:username) { |n| "Admin#{n}" }
    f.password "foobar"
    f.password_confirmation { |u| u.password }
    f.sequence(:email) { |n| "foo#{n}@example.com" } 
    admin true  
  end 
  
  
  factory :product do |f|
    f.sequence(:title) { |n| "foo#{n}" }
    f.sequence(:subtitle) { |n| "bar#{n}" }
    f.description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    f.sequence(:price) { |n| sprintf("%010d", n) }
  end
  
end
