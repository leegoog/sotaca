require File.dirname(__FILE__) + '/../spec_helper'

describe ArticleSet do
  
  before(:each) do
    @set = ArticleSet.create!(:name => 'test', :user_id => 1, :set_items => [])
  end
  
  
  context "with 2 or more comments" do
    it "orders the commens in reverse" do
      comment1 = @set.comments.create!(:user_id => 1, :body => "first")
      comment2 = @set.comments.create!(:user_id => 2, :body => "second")
      @set.reload.comments.should eq([comment2, comment1])
    end
  end
  
  context "with many items" do
    
    before(:each) do
      @set.set_items.build(:product_id => 1, :width => "500", :height => "250", :z_index => "12", :rotation => "120")
      @set.set_items.build(:product_id => 3, :width => "100", :height => "50", :z_index => "9", :rotation => "10")
    end
    
    it "should save the css properties of the items" do
      @set.set_items.should_not be_empty
      @set.set_items.first.width.should_not be_nil
    end
      
  end
  
end
