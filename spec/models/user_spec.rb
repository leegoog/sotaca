require 'spec_helper'

describe User do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  def valid_user_attributes
    {
      :username => "alice",
      :email => "alice@example.com",
      :password => "secret",
      :password_confirmation => "secret"
    }
  end
  
  context "validitions" do   
    let(:alice) { Factory.create(:user)}
    
    it "has a valid username" do
      alice.should be_valid
    end
    
    it "has an valid email adress" do
      alice.should be_valid
    end
    
    it "does not accept an invalid email" do
      alice.email = "@de.ca."
      alice.should_not be_valid
      alice.should have_at_least(1).error_on(:email)
      alice.errors.on(:email).should include("is invalid")
    end
    
    it "should check that password and confirmation match" do
      alice.password_confirmation = "s3cr3t"
      alice.should_not be_valid
    end
    
    it "should use unique usernames" do
      alice2 = User.create(:username => alice.username)
      alice2.should_not be_valid
      alice2.should have_at_least(1).error_on(:username)
      alice2.should have_at_least(1).error_on(:email)
      alice2.errors.on(:username).should include("Username already taken!")
    end
  end
  
end
