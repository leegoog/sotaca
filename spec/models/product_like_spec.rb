require File.dirname(__FILE__) + '/../spec_helper'

describe ProductLike do
  it "should be valid" do
    ProductLike.new.should be_valid
  end
end
