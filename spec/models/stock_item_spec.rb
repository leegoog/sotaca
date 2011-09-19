require File.dirname(__FILE__) + '/../spec_helper'

describe StockItem do
  it "should be valid" do
    StockItem.new.should be_valid
  end
end
