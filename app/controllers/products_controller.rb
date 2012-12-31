class ProductsController < ApplicationController
  before_filter :authenticate_superuser!, :except => [:index, :show]
  
  def index
    if params[:category]
      @category = Category.find(params[:category])
      @products = Product.tree(@category)  # <-- get all products
    else
      @category = false
      @products = Product.scoped(:include => [:assets, :translations])
    end
    @products = Product.active.where("title ilike ? or subtitle ilike ?", "%" + params[:title] + "%", "%" + params[:title] + "%") if params[:title]
    sort = ["created_at", "price", "title"].include?(params[:order]) ? params[:order] : "created_at desc" 
    @products = @products.order(sort).page(params[:page]).per( params[:per_page] ? params[:per_page] : 12)
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id], :include => [:assets, :translations, :stock_items])
    @social_share = SocialShare.new
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
  
  def share_by_mail
    @social_share = SocialShare.new(params[:social_share])
    if @social_share.save
      redirect_to('/', :notice => "Your message was successfully sent.")
    else
      flash[:alert] = t('contact.validation_error')
    end
  end
  
  
end
