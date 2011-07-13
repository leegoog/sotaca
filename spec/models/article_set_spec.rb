require File.dirname(__FILE__) + '/../spec_helper'

describe ArticleSet do
  it "should be valid" do
    ArticleSet.new.should be_valid
  end
  
  context "with 2 or more comments" do
    it "orders them in reverse" do
      set = ArticleSet.create
      comment1 = post.comment("first")
      comment2 = post.comment("second")
      set.reload.comments.should eq([comment2, comment1])
    end
  end
  
end
