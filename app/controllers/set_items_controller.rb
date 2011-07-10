class SetItemsController < ApplicationController
  def create
    @set_item = SetItem.create!(params[:set_item]) 
  end

end
