class StockItemsController < ApplicationController
  
  autocomplete :product, :title, :display_value => :title_code
  
  def get_autocomplete_items(parameters)
    items = Product.select("DISTINCT CONCAT_WS(' ', product_code, title, id) AS full_name, product_code, title, id").where(["CONCAT_WS(' ', product_code, title) LIKE ?", "%#{parameters[:term]}%"])
  end
  
  def index
    @stock_items = StockItem.all
    respond_to do |format|
      format.html
      format.json { render :json => @stock_items.map(&:attributes) }
    end
  end

  def show
    @stock_item = StockItem.find(params[:id])
  end

  def new
    @stock_item = StockItem.new
  end

  def create
    @stock_item = StockItem.new(params[:stock_item])
    if @stock_item.save
      flash[:notice] = "Successfully created stock item."
      redirect_to @stock_item
    else
      render :action => 'new'
    end
  end

  def edit
    @stock_item = StockItem.find(params[:id])
  end

  def update
    @stock_item = StockItem.find(params[:id])
    if @stock_item.update_attributes(params[:stock_item])
      flash[:notice] = "Successfully updated stock item."
      redirect_to stock_item_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @stock_item = StockItem.find(params[:id])
    @stock_item.destroy
    flash[:notice] = "Successfully destroyed stock item."
    redirect_to stock_items_url
  end
end
