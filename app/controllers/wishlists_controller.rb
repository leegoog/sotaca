class WishlistsController < ApplicationController
    before_filter :authenticate_user!
  
  def index
    if current_user.admin?
      @wishlists = Wishlist.all
    else 
      redirect_to current_user.wishlist
    end
  end

  def show
     @wishlist = current_user.wishlist
     @products = @wishlist.products
     sort = ["created_at", "price", "title"].include?(params[:order]) ? params[:order] : "created_at desc" 
     @products = @products.active.order(sort).page(params[:page]).per( params[:per_page] ? params[:per_page] : 12)
  end

  def new
    @wishlist = Wishlist.new
  end

  def create
    @wishlist = Wishlist.create(params[:wishlist])
  end

  def edit
    @wishlist = current_user.wishlist
  end

  def update
    @wishlist = current_user.wishlist
    if @wishlist.update_attributes(params[:wishlist])
      flash[:notice] = "Successfully updated wishlist."
      redirect_to wishlist_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    @wishlist.destroy
    flash[:notice] = "Successfully destroyed wishlist."
    redirect_to wishlists_url
  end
end
