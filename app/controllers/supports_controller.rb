class SupportsController < ApplicationController
  def new
    # id is required to deal with form
    @support = Support.new(:id => 1)
  end
 
  def create
    @support = Support.new(params[:support])
    if @support.save
      redirect_to('/', :notice => "Your message was successfully sent.")
    else
      flash[:alert] = t('contact.validation_error')
      render 'new'
    end
  end
end