class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    if current_user.admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
  
  def change_password
    if current_user
      @user = current_user
    else
      redirect_to root_url
    end
  end
  
  def add_to_wishlist
    @product = Product.find(params[:product_id])
    if current_user
      current_user.add_to_wishlist(@product)
    else
      flash[:notice] = "You need to login to do that"
    end
    respond_to do |format|
      format.html { 
        flash[:notice] = "Added #{@product.title} to wishlist."
        redirect_to product_path(@product)
        }
      format.js
    end
  end
  
  
  def remove_from_wishlist
    @product = Product.find(params[:product_id])
    current_user.remove_from_wishlist(@product)
    respond_to do |format|
      format.html { 
        flash[:notice] = "Removed #{@product.title} from wishlist."
        redirect_to wishlist_url
        }
      format.js
    end
  end


  def update
    @user = User.find(params[:id]) || current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile has been updated."
      redirect_to "/"
    else
      render :action => 'edit'
    end
  end 
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User deleted."
    redirect_to users_url
  end

end
