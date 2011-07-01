class ProductLikesController < ApplicationController
  def index
    @product_likes = ProductLike.all
  end

  def show
    @product_like = ProductLike.find(params[:id])
  end

  def new
    @product_like = ProductLike.new
  end

  def create
    @product_like = ProductLike.new(params[:product_like])
    if @product_like.save
      flash[:notice] = t "like_saved"
      redirect_to product_path(@product_like.product_id)
    else
      flash[:error] = 'error'
      render :action => 'new'
    end
  end

  def edit
    @product_like = ProductLike.find(params[:id])
  end

  def update
    @product_like = ProductLike.find(params[:id])
    if @product_like.update_attributes(params[:product_like])
      flash[:notice] = "Updated"
      redirect_to product_likes_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @product_like = ProductLike.find(params[:id])
    @product_like.destroy
    flash[:notice] = "Deleted."
    redirect_to product_likes_url
  end
end
