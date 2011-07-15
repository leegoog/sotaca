require File.dirname(__FILE__) + '/../spec_helper'

describe ArticleSet do
  
  before(:each) do
    set = Factory(:article_set)
  end
  
  
  
  it "should be valid" do
    ArticleSet.new.should be_valid
  end
  
  context "with 2 or more comments" do
    it "orders them in reverse" do
      set = ArticleSet.create
      comment1 = set.comment("first")
      comment2 = set.comment("second")
      set.reload.comments.should eq([comment2, comment1])
    end
  end
  
end
