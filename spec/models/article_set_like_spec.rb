require File.dirname(__FILE__) + '/../spec_helper'

describe ArticleSetLike do
  it "should be valid" do
    ArticleSetLike.new.should be_valid
  end
end
