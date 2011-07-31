require File.dirname(__FILE__) + '/../spec_helper'

describe ShippingMethodsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => ShippingMethod.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    ShippingMethod.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    ShippingMethod.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(shipping_method_url(assigns[:shipping_method]))
  end

  it "edit action should render edit template" do
    get :edit, :id => ShippingMethod.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    ShippingMethod.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ShippingMethod.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    ShippingMethod.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ShippingMethod.first
    response.should redirect_to(shipping_method_url(assigns[:shipping_method]))
  end

  it "destroy action should destroy model and redirect to index action" do
    shipping_method = ShippingMethod.first
    delete :destroy, :id => shipping_method
    response.should redirect_to(shipping_methods_url)
    ShippingMethod.exists?(shipping_method.id).should be_false
  end
end
