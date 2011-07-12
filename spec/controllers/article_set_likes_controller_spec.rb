require File.dirname(__FILE__) + '/../spec_helper'

describe ArticleSetLikesController do
  fixtures :all
  render_views

  it "create action should render new template when model is invalid" do
    ArticleSetLike.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    ArticleSetLike.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_url)
  end

  it "destroy action should destroy model and redirect to index action" do
    article_set_like = ArticleSetLike.first
    delete :destroy, :id => article_set_like
    response.should redirect_to(root_url)
    ArticleSetLike.exists?(article_set_like.id).should be_false
  end
end
