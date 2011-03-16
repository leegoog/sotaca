require File.dirname(__FILE__) + '/../spec_helper'

describe Image do
  
  def new_image(attributes = {})
    attributes[:title] ||= 'foo'
    attributes[:product_id] ||= '1'
    Image.new(attributes)
  end

  before(:each) do
    Image.delete_all
  end
  
  it "should be valid" do
    new_image.should be_valid
  end
  
  it "should be related to a product" do
    new_image(:product_id => '').should_not be_valid
  end
  
end
