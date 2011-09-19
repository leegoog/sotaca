require File.dirname(__FILE__) + '/../spec_helper'

describe OrderStatusesController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => OrderStatus.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    OrderStatus.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    OrderStatus.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(order_status_url(assigns[:order_status]))
  end

  it "edit action should render edit template" do
    get :edit, :id => OrderStatus.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    OrderStatus.any_instance.stubs(:valid?).returns(false)
    put :update, :id => OrderStatus.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    OrderStatus.any_instance.stubs(:valid?).returns(true)
    put :update, :id => OrderStatus.first
    response.should redirect_to(order_status_url(assigns[:order_status]))
  end

  it "destroy action should destroy model and redirect to index action" do
    order_status = OrderStatus.first
    delete :destroy, :id => order_status
    response.should redirect_to(order_statuses_url)
    OrderStatus.exists?(order_status.id).should be_false
  end
end
