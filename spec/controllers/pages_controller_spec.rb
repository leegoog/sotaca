require 'spec_helper'

describe PagesController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'just_in'" do
    it "should be successful" do
      get 'just_in'
      response.should be_success
    end
  end

  describe "GET 'info'" do
    it "should be successful" do
      get 'info'
      response.should be_success
    end
  end

  describe "GET 'our_story'" do
    it "should be successful" do
      get 'our_story'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'terms'" do
    it "should be successful" do
      get 'terms'
      response.should be_success
    end
  end

  describe "GET 'press'" do
    it "should be successful" do
      get 'press'
      response.should be_success
    end
  end

  describe "GET 'whole_sale'" do
    it "should be successful" do
      get 'whole_sale'
      response.should be_success
    end
  end

  describe "GET 'blog'" do
    it "should be successful" do
      get 'blog'
      response.should be_success
    end
  end

end
