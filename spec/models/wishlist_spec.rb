require File.dirname(__FILE__) + '/../spec_helper'

describe Wishlist do
  it "should be valid" do
    Wishlist.new.should be_valid
  end
end
