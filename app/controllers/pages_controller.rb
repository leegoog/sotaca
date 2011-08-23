class PagesController < ApplicationController
  
  
  def index
  end

  def home
  end

  def just_in
    @products = Product.order('created_at').page(params[:page]).per( params[:per_page] ? params[:per_page] : 25)
    @categories = Category.all
    render 'products/index'
  end

  def info
  end

  def our_story
  end

  def contact
    @support = Support.new(:id => 1)
    render :action => "supports/new"
  end

  def terms
  end

  def press
  end

  def whole_sale
  end

  def blog
  end

end
