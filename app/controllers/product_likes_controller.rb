class ProductLikesController < ApplicationController
  def index
    redirect_to products_url
  end


  def create
    @product_like = ProductLike.new(params[:product_like])
    if @product_like.save
      flash[:notice] = t "like_saved"
      redirect_to product_path(@product_like.product_id)
    else
      deny_access
    end
  end

  def destroy
    @product_like = ProductLike.find(params[:id])
    @product_like.destroy
    flash[:notice] = "Deleted."
    redirect_to product_likes_url
  end
end
