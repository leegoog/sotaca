# require File.expand_path(File.dirname(__FILE__) + "/../../app/models/product")


Given /^I have products titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Product.create!(:title => title, :price => 10)
  end
end

Given /^I have no products$/ do
  Product.delete_all
end


Then /^I should have (\d+) product$/ do |count|
  Product.count.should == count.to_i
end

