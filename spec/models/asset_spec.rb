require 'spec_helper'

describe Asset do
  
  def new_asset(attributes = {})
    attributes[:product_id] ||= '1'
    Asset.new(attributes)
  end

  before(:each) do
    Asset.delete_all
  end
  
  it "should be valid" do
    new_asset.should be_valid
  end
  
  it "should be related to a product" do
    new_asset(:product_id => '').should_not be_valid
  end
end
