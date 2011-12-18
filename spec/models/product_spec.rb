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
  
  it "should not be valid without product name" do
    @test_product = new_product(:title => '')
    @test_product.should_not be_valid
    @test_product.should have(1).error_on(:title)
  end
  
  it "should not be valid without a price" do
    @test_product = new_product(:price => '')
    @test_product.should_not be_valid
    @test_product.should have(1).error_on(:price)
  end
  
end
