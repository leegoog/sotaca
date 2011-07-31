require File.dirname(__FILE__) + '/../spec_helper'

describe ShippingMethod do
  it "should be valid" do
    ShippingMethod.new.should be_valid
  end
end
