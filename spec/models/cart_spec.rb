require File.dirname(__FILE__) + '/../spec_helper'

describe Cart do
  it "should remember the articles inside" do
    Cart.new.should be_valid
  end
end
