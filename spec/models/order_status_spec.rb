require File.dirname(__FILE__) + '/../spec_helper'

describe OrderStatus do
  it "should be valid" do
    OrderStatus.new.should be_valid
  end
end
