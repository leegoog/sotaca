require File.dirname(__FILE__) + '/../spec_helper'

describe Product do  
  
  def new_product(attributes = {})
    attributes[:title] ||= 'foo'
    attributes[:description] ||= 'bar'
    attributes[:price] ||= '19.99'
    Product.new(attributes)
  end

  before(:each) do
    Product.delete_all
  end
  
  
  
  it "should be valid" do
    new_product.should be_valid
  end
  
  it "should not be valid without title" do
    new_product(:title => '').should_not be_valid
    new_product(:title => '').should have(1).error_on(:title)
  end
  
end
