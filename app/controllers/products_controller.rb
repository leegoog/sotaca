class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    if params[:category]
      @products = Category.find(params[:category]).products
    else
      @products = Product.scoped
    end
    @products = @products.where("title like ?", "%" + params[:title] + "%") if params[:title]
    @products = @products.order('created_at').page(params[:page]).per( params[:per_page] ? params[:per_page] : 25)
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id], :include => :sets)
  end

  def new
    @product = Product.new   
    @product.assets.build
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = "Successfully created product."
      redirect_to @product
    else
      render :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    @product.assets.build
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Successfully updated product."
      redirect_to product_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Successfully destroyed product."
    redirect_to products_url
  end
end
