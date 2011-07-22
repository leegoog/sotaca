require File.dirname(__FILE__) + '/../spec_helper'

describe ArticleSet do
  
  let(:set) { Factory.create(:article_set) }

  it "should be valid" do
    set.should be_valid
  end
  
  context "with 2 or more comments" do
    it "orders them in reverse" do
      comment1 = set.comments.create!(:user_id => 1, :body => "first")
      comment2 = set.comments.create!(:user_id => 1, :body => "second")
      set.reload.comments.should eq([comment1, comment2])
    end
  end
  
end
