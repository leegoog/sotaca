require File.dirname(__FILE__) + '/../spec_helper'

describe ArticleSet do
  it "should be valid" do
    ArticleSet.new.should be_valid
  end
end
