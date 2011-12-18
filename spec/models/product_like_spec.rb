require File.dirname(__FILE__) + '/../spec_helper'

describe ProductLike do
  
 
 before(:each) do
   ProductLike.delete_all
 end
 
 
  context "validations" do
    
    let(:like) { ProductLike.new(:user_id => 1, :product_id => 1) }
  
    it "should be have a product id" do
      like.should be_valid
    end
    
    it "should be invalid without user id" do
      like.user_id = nil
      like.should_not be_valid
    end
    
  end
end
  