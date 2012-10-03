class AdressesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @adresses = current_user.adresses
  end

  def show
    @adress = Adress.find(params[:id])
  end

  def new
    if params[:type] == '1'
      @type = "Shipping"
    else
      @type = "Billing"
    end
    @adress = Adress.new
  end

  def create
    @adress = Adress.new(params[:adress])
    if @adress.save
      flash[:notice] = "Successfully created adress."
      redirect_to adresses_path
    else
      render :action => 'new'
    end
  end

  def edit
    @adress = Adress.find(params[:id])
  end

  def update
    @adress = Adress.find(params[:id])
    if @adress.update_attributes(params[:adress])
      flash[:notice] = "Successfully updated adress."
      redirect_to adresses_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @adress = Adress.find(params[:id])
    @adress.destroy
    flash[:notice] = "Successfully deleted adress."
    redirect_to adresses_url
  end
end
